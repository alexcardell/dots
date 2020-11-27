nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD          <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gh          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH          <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s   <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ff   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require 'metals.decoration'.show_hover_message()<CR>
