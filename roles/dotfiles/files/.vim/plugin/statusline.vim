scriptencoding utf-8

highlight ModeMsg ctermfg = 0

" 1 red 2 green 3 yellow 4 blue 5 magenta 6 aqua
" 18 dark grey
highlight StatusLine ctermfg=18 ctermbg=grey
highlight User2 ctermfg=grey ctermbg=18

au InsertEnter * highlight StatusLine ctermfg=18 ctermbg=green |
      \ highlight User2 ctermfg=green ctermbg=18
au InsertLeave * highlight StatusLine ctermfg=18 ctermbg=grey |
      \ highlight User2 ctermfg=grey ctermbg=18

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
