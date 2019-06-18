" Remap keys for gotos
" nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> git :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent> gi :call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nnoremap <leader>rn :call CocActionAsync('rename')<CR>

inoremap <silent> <C-P> <C-O>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

hi CocUnderline cterm=underline,italic
