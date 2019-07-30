if has('autocmd')
  function! s:AlexAutocmds()
    augroup AlexAutocmds
      autocmd!

      autocmd InsertLeave * set nopaste

      if exists('+colorcolumn')
        autocmd BufEnter * let &l:colorcolumn='+' . join(range(0,254), ',+')
      endif

      " Focus background of active window
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(0, 254), ',+')
      autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1, 255), ',')

      " clear trailing whitespace
      autocmd BufWrite * call me#fns#zap()

      " register *.md as markdown filetype
      autocmd BufNewFile,BufReadPost *.md set filetype=markdown

      " register sbt files as scala (for use with scala-metals)
      autocmd BufNewFile,BufReadPost *.sbt set filetype=scala

      " disable status line
      autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

      " Allow comment highlights for json
      " Bucklescript and Coc both allow comments in their json files
      autocmd FileType json syntax match Comment +\/\/.\+$+

     au InsertEnter * highlight StatusLine ctermfg=18 ctermbg=blue |
           \ highlight User2 ctermfg=blue ctermbg=18
     au InsertLeave * highlight StatusLine ctermfg=18 ctermbg=grey |
           \ highlight User2 ctermfg=grey ctermbg=18

    augroup END
  endfunction

  call s:AlexAutocmds()

  " Goyo
  let s:settings={}

  function! s:goyo_enter()
    augroup AlexAutocmds
      autocmd!
    augroup END
    augroup! AlexAutocmds

    let s:settings = {
          \ 'showbreak': &showbreak,
          \ 'cursorline': &cursorline,
          \ 'showmode': &showmode,
          \ 'showcmd': &showcmd
          \ }
    set showbreak=
    set nocursorline
    set noshowmode
    set noshowcmd

    set statusline=\  " comment to ignore zap

    highlight clear EndOfBuffer

    if exists('$TMUX')
      silent !tmux set status off
    endif

  endfunction

  function! s:goyo_leave()
    for [k, v] in items(s:settings)
      execute 'let &' . k . '=' . string(v)
    endfor

    call me#fns#statusline()

    call me#fns#highlights()

    if exists('$TMUX')
      silent !tmux set status on
    endif

    call s:AlexAutocmds()
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
endif
