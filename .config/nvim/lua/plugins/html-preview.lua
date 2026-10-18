return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    "folke/snacks.nvim",                -- Required file picker integration
  },
  ft = { "html", "css", "javascript" }, -- Lazy load only for web files
  cmd = { "LivePreview" },
  keys = {
    { "<leader>hp", "<cmd>LivePreview start<cr>", desc = "HTML Live Preview" },
  },
  config = function()
    require("livepreview.config").set({
      port = 5500,           -- Default port for local server
      browser_command = nil, -- Uses your system's default browser if nil
    })
  end,
}
