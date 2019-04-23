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
