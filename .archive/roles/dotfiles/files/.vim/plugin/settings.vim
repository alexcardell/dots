colorscheme base16-tomorrow-night

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

call me#highlights()

"""
" Screen drawing
set scrolloff=3            " add a 3 line buffer to top/bottom of view
set sidescrolloff=3        " same but for sides
" set lazyredraw             " only update screen when macro finishes
set laststatus=2           " always show statusline
set number relativenumber  " set number and relnumber
set virtualedit=block      " allow visual block to move through empty space
set updatetime=400         " set time for floating window to appear

set splitbelow             " Natural split splitting
set splitright             ""

set colorcolumn=81

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

if has('diffopt')
  set diffopt+=vertical
  set diffopt+=iwhite
  if (has('nvim'))
    set diffopt+=hiddenoff
  endif
endif

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

if has('nvim')
  set inccommand=nosplit
endif

""" General
set confirm            " confirm save/quit
set showcmd
set ignorecase         " ignore case in searches
set spelllang=en_gb,en
set signcolumn=yes     " always show signcolumn

"""
" Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.swo,*.class,*.hg,*.DS_Store,*.min.*
set wildignore+=*/.git
set wildignore+=*/node_modules
