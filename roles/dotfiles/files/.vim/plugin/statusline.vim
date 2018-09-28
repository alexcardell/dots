scriptencoding utf-8

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? ' '.l:branchname.' ' : ' '
endfunction

highlight User1 ctermfg=1 ctermbg=18

set statusline=
set statusline+=%#Error#
set statusline+=\ 
set statusline+=%{StatuslineGit()}
set statusline+=%#User1#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Handy symbols
" powerline left arrow  = 
" powerline right arrow = 
