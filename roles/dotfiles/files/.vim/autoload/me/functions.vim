function! me#functions#zap() abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, '\s\+$', '', ''))
    let l:number=l:number + 1
  endfor
endfunction

function! me#functions#helptags() abort
  source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
  call pathogen#helptags()
endfunction

function! me#functions#goyo_enter() abort
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
  endif
endfunction

function! me#functions#goyo_leave() abort
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
  endif
endfunction
