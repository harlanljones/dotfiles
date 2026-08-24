return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#0d0f16",
        dark_bg    = "#0a0b11",
        darker_bg  = "#07080b",
        lighter_bg = "#25272d",

        fg         = "#7b808a",
        dark_fg    = "#5c6068",
        light_fg   = "#8f939c",
        bright_fg  = "#9ca0a7",
        muted      = "#5f5f5f",

        red        = "#b16371",
        yellow     = "#88785c",
        orange     = "#bd7a86",
        green      = "#6c8064",
        cyan       = "#508381",
        blue       = "#6a7c94",
        purple     = "#8d718c",
        brown      = "#714950",

        bright_red    = "#d38290",
        bright_yellow = "#a8977a",
        bright_green  = "#8b9f82",
        bright_cyan   = "#6fa3a0",
        bright_blue   = "#899bb4",
        bright_purple = "#ad90ac",

        accent               = "#b16371",
        cursor               = "#959aa4",
        foreground           = "#959aa4",
        background           = "#060912",
        selection             = "#25272d",
        selection_foreground = "#959aa4",
        selection_background = "#25272d",
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
