local M = {}

local colours = {
  black = '#000000',
  base01 = '#101112',
  base02 = '#373b41',
  base03 = '#969896',
  base04 = '#b4b7b4',
  base05 = '#c5c8c6',
  base06 = '#e0e0e0',
  base07 = '#ffffff',
  red = '#cc6666',
  orange = '#de935f',
  yellow = '#f0c674',
  lime = '#b5bd68',
  cyan = '#8abeb7',
  blue = '#81a2be',
  violet = '#b294bb',
  brown = '#a3685a'
}

local dark_mode = {
  base00 = colours.black,
  base01 = colours.base01,
  base02 = colours.base02,
  base03 = colours.base03,
  base04 = colours.base04,
  base05 = colours.base05,
  base06 = colours.base06,
  base07 = colours.base07,
  base08 = colours.red,
  base09 = colours.orange,
  base0A = colours.yellow,
  base0B = colours.lime,
  base0C = colours.cyan,
  base0D = colours.blue,
  base0E = colours.violet,
  base0F = colours.brown
}

M.colours = colours

local base16_config = {
  telescope = false,
  indentblankline = false,
  notify = false,
  ts_rainbow = false,
  cmp = false,
  illuminate = false,
  dapui = false,
}

local setup_base16 = function()
  require('base16-colorscheme').with_config(base16_config)
end

local set_dark_mode = function()
  vim.cmd('hi clear')
  vim.api.nvim_set_option_value("background", "dark", {})
  require('base16-colorscheme').with_config(base16_config)
  vim.cmd("colorscheme base16-tomorrow-night")
end

local set_extra_dark_mode = function()
  vim.cmd('hi clear')
  vim.api.nvim_set_option_value("background", "dark", {})
  require('base16-colorscheme').setup(dark_mode, base16_config)
end

local set_light_mode = function()
  vim.cmd('hi clear')
  vim.api.nvim_set_option_value("background", "light", {})
  require('base16-colorscheme').with_config(base16_config)
  vim.cmd("colorscheme base16-tomorrow")
end

local setup_auto_dark_mode = function()
  require('auto-dark-mode').setup({
    update_interval = 2000,
    set_dark_mode = set_dark_mode,
    set_light_mode = set_light_mode,
    fallback = "dark"
  })
end

M.setup = function()
  -- setup_auto_dark_mode()
  set_extra_dark_mode()
end

M.set_dark_mode = set_dark_mode
M.set_light_mode = set_light_mode
M.set_extra_dark_mode = set_extra_dark_mode

return M
