" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> git <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

inoremap <silent> <C-P> <C-O>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('doHover')

hi CocUnderline cterm=underline,italic
