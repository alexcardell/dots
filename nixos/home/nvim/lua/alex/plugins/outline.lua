local M = {}

M.setup = function()
  require('outline').setup({
    outline_window = {
      position = 'left',
      show_numbers = true,
      show_relative_numbers = true,
    },
    outline_items = {
      show_symbol_lineno = true,
    },
    symbols = {
      icon_source = 'lspkind'
    },
    keymaps = {
      show_help = 'g?',
    }
  })
end

return M
