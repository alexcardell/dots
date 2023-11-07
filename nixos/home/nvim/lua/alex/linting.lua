local null_ls = require('null-ls')

local M = {}

local setup_null_ls = function()
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.vale,
    }
  })
end

M.setup = function()
  setup_null_ls()
end

return M
