if has('autocmd')
  function! s:MyAutocmds()
    augroup MyAutocmds
      au!

      au InsertLeave * set nopaste

      if exists('+colorcolumn')
        " Focus background of active window
        au BufEnter,FocusGained,VimEnter,WinEnter * call me#focus()
        au FocusLost,WinLeave * call me#blur()
      endif

      " clear trailing whitespace
      au BufWrite * call me#zap()

      " set script as executable on save
      au BufWritePost * call me#set_executable_if_script(getline(1), expand("%:p"))

      " register *.md as markdown filetype
      au BufNewFile,BufReadPost *.md set filetype=markdown

      " register sbt files as scala (for use with scala-metals)
      au BufNewFile,BufReadPost *.sbt set filetype=scala

      " disable status line
      au  FileType fzf set laststatus=0 noshowmode noruler
        \| au BufLeave <buffer> set laststatus=2 showmode ruler

      " Enable spellchecking
      au FileType markdown,text call me#spell()

      " Update word count for statusline
      au CursorHold,CursorHoldI * call me#update_wordcount()

      " Allow comment highlights for json
      " Bucklescript and Coc both allow comments in their json files
      au FileType json syntax match jsonComment "//\.\+\$"

      au InsertEnter * highlight StatusLine ctermfg=18 ctermbg=blue |
            \ highlight User2 ctermfg=blue ctermbg=18
      au InsertLeave * highlight StatusLine ctermfg=18 ctermbg=grey |
            \ highlight User2 ctermfg=grey ctermbg=18

      " au CursorHold * silent call CocActionAsync('highlight')

      au BufEnter * if &buftype == 'terminal' | :startinsert | endif

      " au VimEnter * let g:vimwiki_syntaxlocal_vars['markdown']['Link1'] = g:vimwiki_syntaxlocal_vars['default']['Link1']

      au FileType scala,sbt lua require("metals").initialize_or_attach(require("metals_config"))
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

    " if exists('$TMUX')
    "   silent !tmux set status off
    " endif

    call me#spell()

  endfunction

  function! s:goyo_leave()
    " if exists('$TMUX')
    "   silent !tmux set status on
    " endif

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
