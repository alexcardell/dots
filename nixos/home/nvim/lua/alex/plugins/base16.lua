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

local light_mode = {
  base00 = '#ffffff',
  base01 = '#e0e0e0',
  base02 = '#d6d6d6',
  base03 = '#8e908c',
  base04 = '#969896',
  base05 = '#4d4d4c',
  base06 = '#282a2e',
  base07 = '#1d1f21',
  base08 = '#c82829',
  base09 = '#f5871f',
  base0A = '#eab700',
  base0B = '#718c00',
  base0C = '#3e999f',
  base0D = '#4271ae',
  base0E = '#8959a8',
  base0F = '#a3685a'
}

local base16_colours = dark_mode

M.colours = colours

M.setup = function()
  require('base16-colorscheme').setup(
    base16_colours,
    {
      telescope = false,
      indentblankline = false,
      notify = false,
      ts_rainbow = false,
      cmp = false,
      illuminate = false,
      dapui = false,
    })
end

return M
