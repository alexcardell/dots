scriptencoding utf-8

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! DisplayGitBranch()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? ' '.l:branchname.' ' : ' '
endfunction

let g:currentmode={
    \ 'n'      : 'N ',
    \ 'no'     : 'N·Operator Pending ',
    \ 'v'      : 'V ',
    \ 'V'      : 'V·Line ',
    \ '\<C-V>' : 'V·Block ',
    \ 's'      : 'Select ',
    \ 'S'      : 'S·Line ',
    \ '\<C-S>' : 'S·Block ',
    \ 'i'      : 'I ',
    \ 'R'      : 'R ',
    \ 'Rv'     : 'V·Replace ',
    \ 'c'      : 'Command ',
    \ 'cv'     : 'Vim Ex ',
    \ 'ce'     : 'Ex ',
    \ 'r'      : 'Prompt ',
    \ 'rm'     : 'More ',
    \ 'r?'     : 'Confirm ',
    \ '!'      : 'Shell ',
    \ 't'      : 'Terminal '
    \}

" 1 red 2 green 3 yellow 4 blue 5 magenta 6 aqua
" 18 dark grey
highlight User1 ctermfg=18 ctermbg=red
highlight User2 ctermfg=red ctermbg=18
highlight ModeMsg ctermfg = 0

function! ModalColorChange()
  if (mode() =~# '\v(n|no)')
    exe 'hi! User1 ctermfg=18 ctermbg=red'
    exe 'hi! User2 ctermfg=red ctermbg=18'
  elseif (mode() =~# '\v(v|V)'
        \ || g:currentmode[mode()] ==# 'V·Block'
        \ || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! User1 ctermfg=18 ctermbg=magenta'
    exe 'hi! User2 ctermfg=magenta ctermbg=18'
  elseif (mode() ==# 'i')
    exe 'hi! User1 ctermfg=18 ctermbg=green'
    exe 'hi! User2 ctermfg=green ctermbg=18'
  endif
  return ''
endfunction

" clear
set statusline=
" red bg
set statusline+=%{ModalColorChange()}
set statusline+=%#User1#
" branch symbol
set statusline+=\ 
" get git branch
set statusline+=%{DisplayGitBranch()}
" red fg powerline symbol TODO: put unicode for this symbol in comment
set statusline+=%#User2#
" text highlight
set statusline+=%#CursorColumn#
" file
set statusline+=\ %f
" modified
set statusline+=\ %m
" start from right
set statusline+=%=
" faint text
set statusline+=%#LineNr#
" filetype
set statusline+=\ %y
" encoding
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}\]
" percent through file
set statusline+=\ %p%%
" line:col
set statusline+=\ %l:%c

" Handy symbols
" powerline left arrow  = 
" powerline right arrow = 
