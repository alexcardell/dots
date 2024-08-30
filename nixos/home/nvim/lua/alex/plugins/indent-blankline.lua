local M = {}

M.setup = function()
  local colours = require('alex/plugins/base16').colours

  local fg = colours.base02

  -- vim.cmd([[ highlight CustomIndentLine ctermfg=Black guifg=#373b41 ]])
  vim.api.nvim_set_hl(0, 'CustomIndentLine', { fg = fg })

  require('ibl').setup({
    indent = {
      char = '│',
      -- char = '╎',
      highlight = { 'CustomIndentLine' }
    },
    scope = { enabled = false }
  })
end

return M
