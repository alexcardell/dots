" Remap keys for gotos
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> git <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nnoremap <leader>rn <Plug>(coc-rename)

inoremap <silent> <C-P> <C-O>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

hi CocUnderline cterm=underline,italic
