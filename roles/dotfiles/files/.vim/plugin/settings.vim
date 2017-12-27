scriptencoding utf-8

let base16colorspace=256
color base16-tomorrow

set mouse=a
set autoindent
set backspace=indent,start,eol
set hidden

set belloff=all
set visualbell t_vb=

"""
" Highlighting
set cursorline
set highlight+=N:DiffText  " current line number highlight
set highlight+=c:LineNr

"""
" Screen drawing
set scrolloff=3
set sidescrolloff=3
set lazyredraw  " only update screen when macro finishes
set laststatus=2 " always show statusline
set number relativenumber
set virtualedit=block

" Line wrapping
set whichwrap=b,s,<,>,[,],~
if has('+linebreak')
  set showbreak='↘'  " u-2198
  set breakindent    " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2  " indent wrapped lines even more
  endif
endif

" Whitespace characters
set list lcs=trail:-,nbsp:∅,tab:▷┅,extends:»,precedes:«

" Folds
set fillchars=vert:┃  " heavy vertical line (U+2503)
set foldmethod=indent
set foldlevelstart=99  " start unfolded

set incsearch
set autoread
set switchbuf=usetab
set smarttab
set expandtab
set shiftwidth=2
set shiftround
set tabstop=2
set textwidth=80


""" General
set confirm
set showcmd

"""
" Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.class
set wildignore+=**/node_modules/
