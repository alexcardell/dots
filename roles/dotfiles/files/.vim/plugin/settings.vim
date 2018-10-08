scriptencoding utf-8

let base16colorspace=256
color base16-tomorrow

set mouse=a                     " enable mouse
set autoindent                  " indent like line above
set backspace=indent,start,eol  " characters that <BS> can move through
set hidden                      " hide buffers instead of closing

set belloff=all
set visualbell t_vb=

"""
" Highlighting
if !has('nvim')
  set highlight+=N:DiffText  " current line number highlight
  set highlight+=c:LineNr    " same
endif

set cursorline             " highlight current line
highlight clear Search     " I don't like the default search highlight
highlight Search cterm=italic,bold,underline ctermfg=red
highlight Comment cterm=italic
highlight String cterm=italic
highlight EndOfBuffer ctermbg=18

"""
" Screen drawing
set scrolloff=3            " add a 3 line buffer to top/bottom of view
set sidescrolloff=3        " same but for sides
set lazyredraw             " only update screen when macro finishes
set laststatus=2           " always show statusline
set number relativenumber  " set number and relnumber
set virtualedit=block      " allow visual block to move through empty space

set splitbelow             " Natural split splitting
set splitright             ""

" Line wrapping
set whichwrap=b,s,<,>,[,],~
if has('linebreak')
  set linebreak                 " wrap at word (if wrap on)
  set showbreak=↘↘↘             " u-2198
  set breakindent               " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2  " indent wrapped lines even more
  endif
endif
set nowrap                      " don't bother soft wrapping globally

" Whitespace characters
set list lcs=trail:-,nbsp:∅,tab:▷┅,extends:»,precedes:«
set fillchars=vert:┃   " (U+2503) (for continuous vsplit break)
set foldmethod=indent  " how to fold
set foldlevelstart=99  " start unfolded
set incsearch          " show match as search is typed
set autoread           " detect filesystem changes
set switchbuf=usetab   " use open buffers and tabs
set smarttab           " autoindent
set expandtab          " expand tabs to spaces
set shiftwidth=2       " spaces to use for autoindent
set shiftround         " round up indentation width
set tabstop=2          " tab width
set textwidth=80       " hard wrap at 80

""" General
set confirm            " confirm save/quit
set showcmd
set ignorecase         " ignore case in searches

"""
" Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.swo,*.class,*.hg,*.DS_Store,*.min.*
set wildignore+=*/.git
set wildignore+=*/node_modules
