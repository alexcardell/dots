local lspconfig = require('lspconfig')
local metals = require('metals')
local inlay_hints = require('lsp-inlayhints')
local navic = require('nvim-navic')

local completion = require('alex/completion')

local on_attach = function(client, bufnr)
  -- disable semantic tokens
  client.server_capabilities.semanticTokensProvider = nil

  inlay_hints.on_attach(client, bufnr, true)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

end

local border = "single"

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local capabilities = completion.capabilities

local M = {}

M.setup_lsp = function()
  vim.lsp.inlay_hint.enable()

  -- extend default capabilities
  lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
      capabilities = capabilities,
    }
  )

  -- nix
  lspconfig.nixd.setup({
    on_attach = on_attach,
    handlers = handlers,
  })

  -- ltex -- markdown/latex
  lspconfig.ltex.setup({
    on_attach = on_attach,
    handlers = handlers,
    filetypes = { 'markdown', 'tex' },
    settings = {
      ltex = {
        language = "en-GB"
      }
    }
  })

  -- lua
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    handlers = handlers,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        }
      }
    }
  })

  -- typescript/javascript
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    handlers = handlers,
  })

  -- terraform
  lspconfig.terraformls.setup({
    on_attach = on_attach,
    handlers = handlers,
  })

  -- smithy
  lspconfig.smithy_ls.setup({
    on_attach = on_attach,
    handlers = handlers,
  })

  -- -- tailwindcss
  -- lspconfig.tailwindcss.setup({
  --   on_attach = on_attach,
  --   handlers = handlers,
  -- })
end

M.metals = metals.bare_config()

M.metals.on_attach = function(client, bufnr)
  metals.setup_dap()
  on_attach(client, bufnr)
end

M.metals.handlers = handlers

M.metals.init_options = {
  statusBarProvider            = "on",
  inputBoxProvider             = true,
  quickPickProvider            = true,
  executeClientCommandProvider = true,
  decorationProvider           = true,
  didFocusProvider             = true,
  debuggingProvider            = true,
}

M.metals.settings = {
  autoImportBuild = "all",
  defaultBspToBuildTool = true,
  enableSemanticHighlighting = false,
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  useGlobalExecutable = true, -- for nix
}

M.metals.capabilities = capabilities

return M
