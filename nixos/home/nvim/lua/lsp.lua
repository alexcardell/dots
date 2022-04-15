local lsp_config = require('lspconfig');
local completion = require('completion');

local on_attach = function ()
  return;
end;

local border = "single"; 

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border});
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border });
};

local capabilities = completion.capabilities();

lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
  capabilities = capabilities,
})

lsp_config.rnix.setup {
  on_attach = on_attach;
  handlers = handlers;
};
