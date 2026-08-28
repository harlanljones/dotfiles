return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    sources = {
      providers = {
        path = {
          -- Path sources triggered by "/" interfere with CopilotChat commands
          enabled = function()
            return vim.bo.filetype ~= "copilot-chat"
          end,
        },
      },
    },
  },
}
