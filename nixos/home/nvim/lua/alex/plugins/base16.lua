local M = {}

M.setup = function ()
  require('base16-colorscheme').with_config({
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
