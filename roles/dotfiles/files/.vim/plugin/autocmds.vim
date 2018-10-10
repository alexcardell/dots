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

    " clear trailing whitespace
    autocmd BufWrite * call me#functions#zap()

    " register *.md as markdown filetype
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  augroup END
endif
