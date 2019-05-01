map <silent> <LocalLeader>n :NERDTreeToggle<CR>
map <LocalLeader>N :NERDTreeFind<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeCascadeSingleChildDir = 1
let g:NERDTreeCascadeOpenSingleChildDir = 1
let g:NERDTreeMinimalUI = 1

" function! s:find_or_open()
"   if &filetype == 'nerdtree'
"     execute 'NERDTreeClose'
"   else
"     if bufname('%') != ""
"       execute 'NERDTreeFind'
"     else
"       execute 'NERDTree'
"     endif
"   endif
" endfunction

" let NERDTreeIgnore = ['\.swp', '\.swo']
let g:NERDTreeRespectWildIgnore=1

" let g:NERDTreeMapJumpLastChild = '<Nop>'
" let g:NERDTreeMapJumpFirstChild = '<Nop>'
" let g:NERDTreeMapJumpNextSibling = 'J'
" let g:NERDTreeMapJumpPrevSibling = 'K'
