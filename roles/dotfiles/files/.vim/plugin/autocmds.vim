if has('autocmd')
  function! s:MyAutocmds()
    augroup MyAutocmds
      autocmd!

      autocmd InsertLeave * set nopaste

      if exists('+colorcolumn')
        " Focus background of active window
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * call me#focus()
        autocmd FocusLost,WinLeave * call me#blur()
      endif

      " clear trailing whitespace
      autocmd BufWrite * call me#zap()

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

      au FileType typescript set syntax=javascript

      autocmd CursorHold * silent call CocActionAsync('highlight')

    augroup END
  endfunction

  call s:MyAutocmds()

  " Goyo
  let s:settings={}

  function! s:goyo_enter()
    augroup MyAutocmds
      autocmd!
    augroup END
    augroup! MyAutocmds

    let s:settings = {
          \ 'cursorline': &cursorline,
          \ 'showmode': &showmode,
          \ 'showcmd': &showcmd
          \ }
    set nocursorline
    set noshowmode
    set noshowcmd

    let &colorcolumn=""

    set statusline=\  " comment to ignore zap

    highlight clear EndOfBuffer
    highlight NonText ctermfg=8

    Limelight

    if exists('$TMUX')
      silent !tmux set status off
    endif

  endfunction

  function! s:goyo_leave()
    if exists('$TMUX')
      silent !tmux set status on
    endif

    Limelight!

    for [k, v] in items(s:settings)
      execute 'let &' . k . '=' . string(v)
    endfor

    call me#statusline()

    call me#highlights()

    call s:MyAutocmds()
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
endif
