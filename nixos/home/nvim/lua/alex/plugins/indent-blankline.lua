local M = {}

M.setup = function()
  local colours = require('alex/components/colours').colours

  local fg = colours.base02


  require('ibl').setup({
    indent = {
      char = '│',
    },
    scope = { enabled = false }
  })
end

return M
