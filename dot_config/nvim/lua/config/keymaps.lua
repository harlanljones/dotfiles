-- Files where git itself asked us to write a message. Exiting these without
-- <leader>P means "abandon": ExitPre below converts that to :cq (non-zero) so
-- git gives up instead of finalizing the commit (and any wrapper script stops
-- before its push). The env marker covers sessions spawned by our own
-- lazygit-ollama-commit.sh, whose message buffer is a /tmp file, not
-- COMMIT_EDITMSG.
local function is_git_editor_session()
  if vim.env.NVIM_GIT_EDITOR_SESSION == "1" then
    return true
  end
  local ft = vim.bo.filetype
  local bufname = vim.fn.expand("%:t")
  return ft == "gitcommit"
    or bufname == "COMMIT_EDITMSG"
    or bufname == "MERGE_MSG"
    or bufname == "TAG_EDITMSG"
end

vim.api.nvim_create_autocmd("ExitPre", {
  group = vim.api.nvim_create_augroup("git-editor-abort", { clear = true }),
  callback = function(args)
    if not is_git_editor_session() then
      return
    end
    if vim.g.git_editor_approved then
      vim.g.git_editor_approved = nil
      return
    end
    -- Delete first so our own :cq! doesn't re-enter.
    vim.api.nvim_del_autocmd(args.id)
    vim.notify("Commit abandoned", vim.log.levels.WARN)
    vim.cmd("cq!")
  end,
})

-- Open CopilotChat without replacing an existing mapping.
if vim.fn.maparg("<leader>cc", "n") == "" then
  vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", {
    silent = true,
    desc = "Open CopilotChat",
  })
end

-- Save all, git commit (message drafted by ollama), git push, quit all
vim.keymap.set("n", "<leader>P", function()
  -- When nvim is git's editor (lazygit <c-g>, `git commit`, rebase todo), the
  -- outer git process owns the commit. Committing from in here moves HEAD out
  -- from under it and it dies with "cannot lock ref 'HEAD'" (exit 128), so
  -- just save the message and hand control back. Approved via <leader>P only;
  -- every other exit path aborts (see ExitPre above).
  local ft = vim.bo.filetype
  local bufname = vim.fn.expand("%:t")
  local git_buf = is_git_editor_session()
    or ft == "gitrebase"
    or bufname == "git-rebase-todo"
  if git_buf or vim.env.GIT_INDEX_FILE then
    vim.g.git_editor_approved = true
    vim.cmd("silent! wall")
    vim.notify("Saved; letting git finish.", vim.log.levels.INFO)
    vim.schedule(function()
      vim.cmd("qa")
    end)
    return
  end

  vim.cmd("silent! wall")

  local root = vim.fn.getcwd()
  local msg_generator = vim.fn.expand("~/.local/bin/ollama-commit-msg.sh")

  local function git(...)
    return vim.system({ "git", ... }, { cwd = root, text = true }):wait()
  end

  local function fail(out, fallback)
    local msg = out.stderr ~= "" and out.stderr or (out.stdout ~= "" and out.stdout or fallback)
    vim.notify(vim.trim(msg), vim.log.levels.ERROR)
  end

  if git("rev-parse", "--is-inside-work-tree").code ~= 0 then
    vim.notify("Not a git repository: " .. root, vim.log.levels.ERROR)
    return
  end

  local dirty = vim.trim(git("status", "--porcelain").stdout) ~= ""

  local function push_and_quit(committed_msg)
    local push = git("push")
    if push.code ~= 0 then
      return fail(push, "git push failed")
    end
    vim.notify(
      committed_msg and ("Committed and pushed: " .. committed_msg) or "Nothing to commit; push up to date. Bye!",
      vim.log.levels.INFO
    )
    vim.schedule(function()
      vim.cmd("qa!")
    end)
  end

  if not dirty then
    return push_and_quit(nil)
  end

  -- Stage everything first so the generator sees the same diff we'll commit.
  local add = git("add", "-A")
  if add.code ~= 0 then
    return fail(add, "git add failed")
  end

  local function prompt_and_commit(default_msg)
    vim.ui.input({ prompt = "Commit message: ", default = default_msg }, function(msg)
      if not msg or vim.trim(msg) == "" then
        vim.notify("Aborted: no commit message (changes left staged)", vim.log.levels.WARN)
        return
      end
      msg = vim.trim(msg)
      local commit = git("commit", "-m", msg)
      if commit.code ~= 0 then
        return fail(commit, "git commit failed")
      end
      push_and_quit(msg)
    end)
  end

  local fallback_msg = os.date("chore: update %Y-%m-%d %H:%M")

  if vim.fn.executable(msg_generator) ~= 1 then
    return prompt_and_commit(fallback_msg)
  end

  -- Draft the message with the local model, then prompt. Async so nvim stays
  -- responsive; the generator enforces its own OLLAMA_TIMEOUT.
  vim.notify("Generating commit message...", vim.log.levels.INFO)
  vim.system({ msg_generator }, { cwd = root, text = true }, function(out)
    vim.schedule(function()
      local subject = vim.split(vim.trim(out.stdout or ""), "\n", { plain = true })[1] or ""
      if out.code ~= 0 or subject == "" then
        vim.notify("Ollama message failed, using fallback: " .. vim.trim(out.stderr or ""), vim.log.levels.WARN)
        return prompt_and_commit(fallback_msg)
      end
      prompt_and_commit(subject)
    end)
  end)
end, { desc = "Write all, Git commit (ollama msg), push, quit all" })
