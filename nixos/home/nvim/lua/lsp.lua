local lsp_config = require('lspconfig')
local completion = require('completion')
local metals = require('metals')

local on_attach = function ()
  return
end

local border = "single" 

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local capabilities = completion.capabilities()

local M = {}

M.setup_lsp = function () 
    lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
      capabilities = capabilities,
    })
    
    lsp_config.rnix.setup {
      on_attach = on_attach,
      handlers = handlers,
    }
  end

M.metals = metals.bare_config()

M.metals.on_attach = on_attach

M.metals.init_options = {
     statusBarProvider            = "off",
     inputBoxProvider             = true,
     quickPickProvider            = true,
     executeClientCommandProvider = true,
     decorationProvider           = true,
     didFocusProvider             = true,
     debuggingProvider            = true,
   }

M.metals.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    useGlobalExecutable = true, -- for nix
}

M.metals.capabilities = capabilities

M.metals.handlers = handlers

return M
