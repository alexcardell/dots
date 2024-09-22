local lspconfig = require('lspconfig')
local metals = require('metals')

local M = {}

local capabilities = require('alex/components/completion').capabilities

local default_on_attach = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

local border = "rounded"

local default_handlers = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = border }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = border }
  ),
}

local setup_server = function(lsp, settings, handlers, on_attach)
  handlers = handlers or default_handlers
  on_attach = on_attach or default_on_attach

  if settings then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = settings
    })
  else
    lspconfig[lsp].setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = settings
    })
  end
end

local setup_metals = function()
  local config = metals.bare_config()

  config.init_options = {
    statusBarProvider = "off",
    debuggingProvider = true
  }

  config.settings = {
    autoImportBuild                   = "all",
    defaultBspToBuildTool             = true,
    enableSemanticHighlighting        = false,
    showImplicitArguments             = true,
    showImplicitConversionsAndClasses = true,
    showInferredType                  = true,
    useGlobalExecutable               = true, -- for nix
    -- testUserInterface                 = "Test Explorer"
  }

  config.capabilities = capabilities

  config.on_attach = function(client, bufnr)
    metals.setup_dap()
    default_on_attach(client, bufnr)
  end

  config.handlers = default_handlers

  vim.api.nvim_create_autocmd('Filetype', {
    pattern = { "java", "scala", "sbt" },
    desc = 'Initialize or attach metals',
    group = vim.api.nvim_create_augroup(
      'metals',
      { clear = true }
    ),
    callback = function()
      metals.initialize_or_attach(config)
    end,
  })
end

M.setup = function()
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
  })

  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      capabilities = capabilities,
    }
  )

  -- anything with standard empty configuration
  local standard_servers = {
    'nixd',
    'smithy_ls',
    'terraformls',
    'ts_ls',
  }

  for _, server in ipairs(standard_servers) do
    setup_server(server)
  end

  setup_server("ltex", {
    ltex = {
      language = "en-GB",
      motherTongue = "en-GB"
    },
  })

  setup_server("lua_ls", {
    Lua = {
      runtime = { version = 'LuaJIT', },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  })

  setup_metals()
end

return M
