let g:metals_server_version = '0.9.7'
let g:metals_decoration_color = 'WarningMsg'

lua <<EOF

local lsp    = require'lspconfig'
local comp   = require'completion'
local metals = require'metals'
local setup = require'metals.setup'
local M      = {}

M.on_attach = function()
    comp.on_attach()
    setup.auto_commands()
  end

lsp.metals.setup{
  on_attach    = M.on_attach;
  init_options = {
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

  handlers = {
    ["textDocument/hover"]          = metals['textDocument/hover'];
    ["metals/status"]               = metals['metals/status'];
    ["metals/inputBox"]             = metals['metals/inputBox'];
    ["metals/quickPick"]            = metals['metals/quickPick'];
    ["metals/executeClientCommand"] = metals["metals/executeClientCommand"];
    ["metals/publishDecorations"]   = metals["metals/publishDecorations"];
    ["metals/didFocusTextDocument"] = metals["metals/didFocusTextDocument"];
  };

  settings = {
    showImplicitArguments = true;
    showInferredType = true;
    superMethodLensesEnabled = true;
  };
}

lsp.dockerls.setup{on_attach=comp.on_attach}
lsp.hls.setup{on_attach=comp.on_attach}
lsp.jdtls.setup{on_attach=comp.on_attach}
lsp.tsserver.setup{on_attach=comp.on_attach}
lsp.vimls.setup{on_attach=comp.on_attach}

EOF

nnoremap <silent> <localleader>d    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <localleader>t    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <localleader>h    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>H    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <localleader>l    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> ]d                <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [d                <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <localleader>i    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <localleader>r    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <localleader>ws   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <localleader>R    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <localleader>ff   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <localleader>ca   <cmd>lua vim.lsp.buf.code_action()<CR>

" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
