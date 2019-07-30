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

    " register sbt files as scala (for use with scala-metals)
    autocmd BufNewFile,BufReadPost *.sbt set filetype=scala

    " disable status line
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    autocmd User GoyoEnter nested call me#functions#goyo_enter()
    autocmd User GoyoLeave nested call me#functions#goyo_leave()

    " Allow comment highlights for json
    " Bucklescript and Coc both allow comments in their json files
    autocmd FileType json syntax match Comment +\/\/.\+$+

  augroup END
endif
