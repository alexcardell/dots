local M = {}

local lspconfig = require('lspconfig')

M.setup = function()
  -- anything with standard empty configuration
  local standard_servers = {
    'ltex',
    'lua_ls',
    'nixd',
    'smithy_ls',
    'terraformls',
    'tsserver',
  }

  for _, server in ipairs(standard_servers) do
    lspconfig[server].setup({})
  end
end

return M
