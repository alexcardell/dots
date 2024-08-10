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

  local capabilities = require('alex/components/completion').capabilities

  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      capabilities = capabilities,
    }
  )

  for _, server in ipairs(standard_servers) do
    lspconfig[server].setup({})
  end
end

return M
