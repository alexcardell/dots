local lsp_config = require('lspconfig');

local on_attach = function ()
  return;
end;

local border = "single"; 

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border});
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border });
};

lsp_config.rnix.setup {
  on_attach = on_attach;
  handlers = handlers;
};
