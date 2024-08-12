local lspconfig = require('lspconfig')
local metals_ = require('metals')

local M = {}

local capabilities = require('alex/components/completion').capabilities

M.setup = function()
  vim.lsp.inlay_hint.enable()

  -- anything with standard empty configuration
  local standard_servers = {
    'ltex',
    'lua_ls',
    'nixd',
    'smithy_ls',
    'terraformls',
    'tsserver',
  }

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

  local metals = metals_.bare_config()

  metals.init_options = {
    statusBarProvider            = "off",
  }

  metals.settings = {
    autoImportBuild = "all",
    defaultBspToBuildTool = true,
    enableSemanticHighlighting = true,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    useGlobalExecutable = true, -- for nix
  }

  metals.capabilities = capabilities

  vim.api.nvim_create_autocmd('Filetype', {
    pattern = {"java", "scala", "sbt"},
    desc = 'Initialize or attach metals',
    group = vim.api.nvim_create_augroup('metals', { clear = true }),
    callback = function()
      metals_.initialize_or_attach(metals)
    end,
  })


end

return M
