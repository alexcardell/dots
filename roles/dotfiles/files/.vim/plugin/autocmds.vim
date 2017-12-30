if has('autocmd')
  augroup autocmds
    autocmd!
    if exists('+colorcolumn')
      autocmd BufEnter * let &l:colorcolumn='+' . join(range(0,254), ',+')
    endif
  augroup END
endif
