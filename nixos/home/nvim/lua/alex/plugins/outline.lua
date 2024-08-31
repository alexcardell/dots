local M = {}

M.setup = function()
  require('outline').setup({
    symbols = {
      icon_source = 'lspkind'
    },
    keymaps = {}
  })
end

return M
