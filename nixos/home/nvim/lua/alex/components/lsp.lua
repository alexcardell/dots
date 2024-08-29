local lspconfig = require('lspconfig')
local metals_ = require('metals')

local M = {}

local capabilities = require('alex/components/completion').capabilities

local default_on_attach = function(client, bufnr)
  -- disable semantic tokens
  client.server_capabilities.semanticTokensProvider = nil

  -- inlay_hints.on_attach(client, bufnr, true)

  -- if client.server_capabilities.documentSymbolProvider then
  --   navic.attach(client, bufnr)
  -- end
end


local setup_metals = function()
  local metals = metals_.bare_config()

  metals.init_options = {
    statusBarProvider = "off",
  }

  metals.settings = {
    autoImportBuild = "all",
    defaultBspToBuildTool = true,
    enableSemanticHighlighting = false,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    useGlobalExecutable = true, -- for nix
  }

  metals.capabilities = capabilities

  metals.on_attach = default_on_attach

  vim.api.nvim_create_autocmd('Filetype', {
    pattern = { "java", "scala", "sbt" },
    desc = 'Initialize or attach metals',
    group = vim.api.nvim_create_augroup(
      'metals',
      { clear = true }
    ),
    callback = function()
      metals_.initialize_or_attach(metals)
    end,
  })
end

M.setup = function()
  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      capabilities = capabilities,
    }
  )

  -- anything with standard empty configuration
  local standard_servers = {
    'lua_ls',
    'nixd',
    'smithy_ls',
    'terraformls',
    'tsserver',
  }

  for _, server in ipairs(standard_servers) do
    lspconfig[server].setup({
      on_attach = default_on_attach
    })
  end

  lspconfig.ltex.setup({
    on_attach = default_on_attach,
    filetypes = { 'markdown', 'tex' },
    settings = {
      ltex = {
        language = "en-GB",
        motherTongue = "en-GB"
      },
    },
  })

  setup_metals()
end

return M
