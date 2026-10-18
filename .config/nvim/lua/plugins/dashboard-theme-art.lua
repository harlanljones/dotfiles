-- Dashboard header: the theme-synced ASCII art in ~/.config/omarchy/branding/
-- about.txt (Diocletian's temple, or the figlet machine-name wordmark that the
-- theme-art hook renders for other themes). It takes the colorscheme's
-- SnacksDashboardHeader color. Below it: recent files, projects, startup time.
local ART = vim.fn.expand("~/.config/omarchy/branding/about.txt")

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local f = io.open(ART, "r")
    if not f then
      return
    end
    local art = f:read("*a"):gsub("%s+$", "")
    f:close()

    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.header = art
    opts.dashboard.sections = {
      { section = "header" },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { section = "startup" },
    }
  end,
}
