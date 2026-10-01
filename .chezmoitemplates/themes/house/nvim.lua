-- Omarchy House theme
return {
  setup = function()
    vim.o.background = "dark"
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") == 1 then
      vim.cmd("syntax reset")
    end
    vim.g.colors_name = "dots-house"

    local c = {
      bg = "#110402",
      bg_dark = "#0d0302",
      bg_light = "#200e0c",
      fg = "#f0e5e3",
      fg_dim = "#a29694",
      accent = "#f451d3",
      muted = "#7d5952",
      selection = "#511a3d",
      red = "#fe3f50",
      yellow = "#ffe5b3",
      orange = "#ffa367",
      green = "#11e97e",
      cyan = "#17e8d9",
      blue = "#387eff",
      magenta = "#f451d3",
    }

    local hi = function(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    hi("Normal", { fg = c.fg, bg = c.bg })
    hi("NormalFloat", { fg = c.fg, bg = c.bg_dark })
    hi("Comment", { fg = c.muted, italic = true })
    hi("Constant", { fg = c.orange })
    hi("String", { fg = c.green })
    hi("Identifier", { fg = c.fg })
    hi("Function", { fg = c.blue })
    hi("Statement", { fg = c.magenta })
    hi("Keyword", { fg = c.magenta })
    hi("Type", { fg = c.yellow })
    hi("Special", { fg = c.cyan })
    hi("Underlined", { fg = c.blue, underline = true })
    hi("Error", { fg = c.bg, bg = c.red })
    hi("Todo", { fg = c.bg, bg = c.yellow })
    hi("LineNr", { fg = c.muted })
    hi("CursorLine", { bg = c.bg_light })
    hi("CursorLineNr", { fg = c.accent })
    hi("Visual", { bg = c.selection })
    hi("Search", { fg = c.bg, bg = c.yellow })
    hi("Pmenu", { fg = c.fg, bg = c.bg_dark })
    hi("PmenuSel", { fg = c.bg, bg = c.accent })
    hi("StatusLine", { fg = c.fg, bg = c.bg_dark })
    hi("StatusLineNC", { fg = c.fg_dim, bg = c.bg_dark })
    hi("DiffAdd", { fg = c.green, bg = c.bg_dark })
    hi("DiffDelete", { fg = c.red, bg = c.bg_dark })
    hi("DiffChange", { fg = c.blue, bg = c.bg_dark })
  end,
}
