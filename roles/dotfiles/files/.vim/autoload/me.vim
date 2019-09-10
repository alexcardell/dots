function! me#zap() abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, '\s\+$', '', ''))
    let l:number=l:number + 1
  endfor
endfunction

function! me#helptags() abort
  source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
  call pathogen#helptags()
endfunction

function! me#statusline()
  " clear
  set statusline=
  " red bg
  set statusline+=%#StatusLine#
  " branch information
  set statusline+=\ \ %{fugitive#head()}
  " powerline symbol TODO: put unicode for this symbol in comment
  set statusline+=\ %#User2#
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
endfunction

function! me#highlights()
  highlight clear Search
  highlight Search cterm=italic,bold,underline ctermfg=red
  highlight Comment cterm=italic
  highlight String cterm=italic
  highlight EndOfBuffer ctermbg=18 ctermfg=18

  " 1 red 2 green 3 yellow 4 blue 5 magenta 6 aqua
  " 18 dark grey
  highlight ModeMsg ctermfg = 0
  highlight StatusLine ctermfg=18 ctermbg=grey
  highlight User2 ctermfg=grey ctermbg=18

  if has('nvim')
    highlight Pmenu ctermfg=7 ctermbg=19
  endif
endfunction
