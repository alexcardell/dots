let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio'],
    \ }

nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <C-[> :call LanguageClient#textDocument_references()<bar>lopen<CR>
