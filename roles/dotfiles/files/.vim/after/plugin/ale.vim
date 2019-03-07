let g:ale_linters = {
      \ 'javascript': ['eslint', 'flow-language-server']
      \}

let g:ale_fixers = {
      \ 'javascript': ['eslint']
      \}

highlight link ALEErrorSign DiffDelete

let g:ale_typescript_tsserver_use_global=1

nnoremap gd :ALEGoToDefinition<CR>
nnoremap gh :ALEHover<CR>
nnoremap gr :ALEFindReferences<CR>
