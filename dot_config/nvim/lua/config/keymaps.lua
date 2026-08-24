-- Save all, git commit, git push, quit all
vim.keymap.set("n", "<leader>P", function()
  vim.cmd("silent! wall")

  local root = vim.fn.getcwd()
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
  local function commit_and_push(msg)
    if dirty then
      local add = git("add", "-A")
      if add.code ~= 0 then
        return fail(add, "git add failed")
      end
      local commit = git("commit", "-m", msg)
      if commit.code ~= 0 then
        return fail(commit, "git commit failed")
      end
    end

    local push = git("push")
    if push.code ~= 0 then
      return fail(push, "git push failed")
    end

    vim.notify(dirty and ("Committed and pushed: " .. msg) or "Nothing to commit; push up to date. Bye!", vim.log.levels.INFO)
    vim.schedule(function()
      vim.cmd("qa!")
    end)
  end

  if not dirty then
    return commit_and_push()
  end

  vim.ui.input({
    prompt = "Commit message: ",
    default = os.date("chore: update %Y-%m-%d %H:%M"),
  }, function(msg)
    if not msg or vim.trim(msg) == "" then
      vim.notify("Aborted: no commit message", vim.log.levels.WARN)
      return
    end
    commit_and_push(vim.trim(msg))
  end)
end, { desc = "Write all, Git commit, push, quit all" })
