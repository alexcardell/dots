local null_ls = require('null-ls')
local builtins = null_ls.builtins

local M = {}

local setup_null_ls = function()
  null_ls.setup({
    sources = {
      builtins.diagnostics.vale,
      -- builtins.diagnostics.ltrs,
      -- builtins.code_actions.ltrs,
    }
  })
end

M.setup = function()
  setup_null_ls()
end

return M
