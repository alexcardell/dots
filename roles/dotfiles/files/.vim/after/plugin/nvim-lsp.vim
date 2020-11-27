nnoremap <silent> <localleader>d    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <localleader>D    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <localleader>h    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>H    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <localleader>i    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <localleader>r    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <localleader>ws   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <localleader>rn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <localleader>ff   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <localleader>ca   <cmd>lua vim.lsp.buf.code_action()<CR>

" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
