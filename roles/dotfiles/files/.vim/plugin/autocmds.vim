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

      " disable status line
      au  FileType fzf set laststatus=0 noshowmode noruler
        \| au BufLeave <buffer> set laststatus=2 showmode ruler

      au InsertEnter * highlight StatusLine ctermfg=18 ctermbg=blue |
            \ highlight User2 ctermfg=blue ctermbg=18
      au InsertLeave * highlight StatusLine ctermfg=18 ctermbg=grey |
            \ highlight User2 ctermfg=grey ctermbg=18

      au BufEnter * if &buftype == 'terminal' | :startinsert | endif

      " register sbt files as scala
      au BufNewFile,BufReadPost *.sbt set filetype=scala

      au FileType scala,sbt lua require("metals").initialize_or_attach(require("alex.metals").metals)

      " au CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb(require("alex.lightbulb").lightbulb)

      au BufEnter,CursorHold,CursorHoldI,InsertLeave * lua vim.lsp.codelens.refresh()

      " load nvim-lint
      au BufEnter,CursorHold,CursorHoldI,InsertLeave *.md lua require('alex.lint').try_lint()

      au FileType markdown call pencil#init()

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

  endfunction

  function! s:goyo_leave()
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
