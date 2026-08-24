-- Save all, git push, quit all
vim.keymap.set("n", "<leader>P", function()
  vim.cmd("silent! wall")
  local out = vim.system({ "git", "push" }, { cwd = vim.fn.getcwd() }):wait()
  if out.code == 0 then
    vim.notify("Pushed. Bye!", vim.log.levels.INFO)
    vim.schedule(function()
      vim.cmd("qa!")
    end)
  else
    vim.notify(out.stderr ~= "" and out.stderr or "git push failed", vim.log.levels.ERROR)
  end
end, { desc = "Write all, Git push, quit all" })
