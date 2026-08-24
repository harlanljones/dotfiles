return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#000000",
        dark_bg    = "#000000",
        darker_bg  = "#000000",
        lighter_bg = "#1a1a1a",

        fg         = "#e9f4ff",
        dark_fg    = "#afb7bf",
        light_fg   = "#ecf6ff",
        bright_fg  = "#eff7ff",
        muted      = "#686163",

        red        = "#a189a8",
        yellow     = "#ffdcff",
        orange     = "#af9bb5",
        green      = "#a4c2e9",
        cyan       = "#c1d5ff",
        blue       = "#7b789e",
        purple     = "#b19fce",
        brown      = "#695d6d",

        bright_red    = "#ba9cc2",
        bright_yellow = "#ffdaff",
        bright_green  = "#b2daff",
        bright_cyan   = "#d2ecff",
        bright_blue   = "#8f8cbb",
        bright_purple = "#c9b2ee",

        accent               = "#7b789e",
        cursor               = "#e9f4ff",
        foreground           = "#e9f4ff",
        background           = "#000000",
        selection             = "#1a1a1a",
        selection_foreground = "#e9f4ff",
        selection_background = "#1a1a1a",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
