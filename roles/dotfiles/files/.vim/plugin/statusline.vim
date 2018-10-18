scriptencoding utf-8

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? ' '.l:branchname.' ' : ' '
endfunction

highlight User1 ctermfg=1 ctermbg=18

" clear
set statusline=
" red bg
set statusline+=%#Error#
" branch symbol
set statusline+=\ 
" get git branch
set statusline+=%{StatuslineGit()}
" red fg powerline symbol TODO: put unicode for this symbol in comment
set statusline+=%#User1#
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
