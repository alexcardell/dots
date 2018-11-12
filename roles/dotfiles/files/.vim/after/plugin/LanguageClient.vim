let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio'],
    \ }
let g:LanguageClient_diagnosticsEnable=0  " fix loclist clearing all the time

nnoremap <C-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>] :call LanguageClient#textDocument_references()<bar>lopen<CR>
