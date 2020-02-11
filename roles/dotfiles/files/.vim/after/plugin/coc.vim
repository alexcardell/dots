" Remap keys for gotos
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
" nnoremap <silent> gd <Plug>(coc-definition)

nnoremap <silent> gy :call CocActionAsync('jumpTypeDefinition')<CR>
" nnoremap <silent> go <Plug>(coc-type-definition)

nnoremap <silent> gi :call CocActionAsync('jumpImplementation')<CR>
" nnoremap <silent> gi <Plug>(coc-implementation)

nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
" nnoremap <silent> gr <Plug>(coc-references)

" nnoremap <silent> ga :call CocActionAsync('codeLensAction')<CR>
xnoremap ga <Plug>(coc-codeaction-selected)
nnoremap ga <Plug>(coc-codeaction-selected)
nnoremap gac <Plug>(coc-codeaction)
" nnoremap <silent> gA :call CocActionAsync('codeAction')<CR>

nnoremap <silent> gh :call <SID>show_documentation()<CR>

nnoremap <silent> <localleader>r :call CocActionAsync('rename')<CR>
" nnoremap <silent> <leader>r <Plug>(coc-refactor)

nnoremap <silent> <leader>p :call CocActionAsync('format')<CR>
" nnoremap <silent> <leader>p <Plug>(coc-format)
" vnoremap <silent> <leader>p <Plug>(coc-format-selected)

inoremap <silent> <C-P> <C-O>:call CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

hi CocUnderline cterm=underline,italic

command! -nargs=0 JestCurrent :call CocAction('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 Jest :call CocAction('runCommand', 'jest.projectTest')
