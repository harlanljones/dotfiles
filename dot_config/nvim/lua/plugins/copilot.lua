-- Copilot runs via LazyVim's ai.copilot extra: copilot.lua only starts the
-- language server; ghost text is a blink-copilot completion source, so TAB
-- (super-tab preset in blink-cmp.lua) accepts it like any other completion.
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        -- We draft commit messages in lazygit's editor (see keymaps.lua);
        -- copilot's default deny list blocks gitcommit.
        gitcommit = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          copilot = {
            opts = {
              -- One inline suggestion; extra candidates just clutter the menu
              max_completions = 1,
              -- Wait a beat so ghost text doesn't flicker while typing
              debounce = 250,
            },
          },
        },
      },
    },
  },
}
