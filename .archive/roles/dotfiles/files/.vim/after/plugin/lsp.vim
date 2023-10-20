lua require('alex.lsp')

nnoremap <silent> gd   <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <localleader>d   <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <localleader>t   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K   <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>h   <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>H   <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <localleader>]   <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <localleader>[   <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <localleader>i   <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <localleader>R   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <localleader>s   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <localleader>l   <cmd>lua vim.lsp.codelens.run()<CR>
nnoremap <silent> <localleader>r   <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> <localleader>c   <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> <localleader>c   <cmd>lua vim.lsp.buf.range_code_action()<CR>

nnoremap <silent> <localleader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
vnoremap <silent> <localleader>f   <cmd>lua vim.lsp.buf.range_formatting()<CR>

nnoremap <silent> <localleader>x  <cmd>lua require('diaglist').open_all_diagnostics()<cr>
nnoremap <silent> <localleader>X  <cmd>lua require('diaglist').open_buffer_diagnostics()<cr>

" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s <cmd>lua require'telescope.builtin'.lsp_references{}<CR>