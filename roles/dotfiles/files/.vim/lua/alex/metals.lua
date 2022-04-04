vim.g['metals_server_version'] = '0.11.1'

local metals = require'metals'

local signature = require('lsp_signature')
local signature_config = require('alex/signature').config()

local completion = require('alex/completion')
completion.setup()

local capabilities = completion.capabilities();

local M = {}

M.metals = metals.bare_config()

M.metals.on_attach = function(client, bufnr)
  signature.on_attach(signature_config)
  metals.setup_dap()
end

M.metals.init_options = {
  -- If you set this, make sure to have the `metals#status()` function
  -- in your statusline, or you won't see any status messages
  statusBarProvider            = "on";
  inputBoxProvider             = true;
  quickPickProvider            = true;
  executeClientCommandProvider = true;
  decorationProvider           = true;
  didFocusProvider             = true;
  debuggingProvider            = true;
};

M.metals.settings = {
    showImplicitArguments = true;
    showInferredType = true;
};

M.metals.capabilities = capabilities;

local border = "single"

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border});
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border });
}

M.metals.handlers = handlers

return M
