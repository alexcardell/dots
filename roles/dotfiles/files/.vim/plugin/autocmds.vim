if has('autocmd')
  augroup autocmds
    autocmd!

    autocmd InsertLeave * set nopaste

    if exists('+colorcolumn')
      autocmd BufEnter * let &l:colorcolumn='+' . join(range(0,254), ',+')
    endif

    " Focus background of active window
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(0, 254), ',+')
    autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1, 255), ',')

    " open NERDTree on startup with no args
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " clear trailing whitespace
    autocmd BufWrite * call cardell#functions#zap()
  augroup END
endif
