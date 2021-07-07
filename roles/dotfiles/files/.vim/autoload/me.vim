function! me#zap() abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, '\s\+$', '', ''))
    let l:number=l:number + 1
  endfor
endfunction

function! me#statusline() abort
  " clear
  set statusline=
  " red bg
  set statusline+=%#StatusLine#
  " branch information
  set statusline+=\ \ %{fugitive#head()}
  " powerline symbol
  set statusline+=\ %#User2#
  " text highlight
  set statusline+=%#CursorColumn#
  " file
  set statusline+=\ %f
  " modified
  set statusline+=\ %m
  " start from right
  set statusline+=%=
  " faint text
  set statusline+=%#LineNr#
  " metals
  set statusline+=%{metals#status()}
  " filetype
  set statusline+=\ %y
  " encoding
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}\]
  " percent through file
  set statusline+=\ %p%%
  " line:col
  set statusline+=\ %l:%c

  " Handy symbols
  " powerline left arrow  = 
  " powerline right arrow = 
endfunction

function! me#highlights() abort

  " Print colors:
  " curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
  highlight clear Search
  highlight Italic cterm=italic
  highlight Search cterm=italic,bold,underline ctermfg=red
  highlight Comment cterm=italic
  highlight String cterm=italic
  highlight EndOfBuffer ctermbg=18 ctermfg=18

  highlight SpellBad ctermfg=8 ctermbg=52
  highlight SpellLocal ctermfg=0
  highlight SpellCap ctermfg=0
  highlight SpellRare ctermfg=0

  highlight ModeMsg ctermfg = 0
  highlight StatusLine ctermfg=18 ctermbg=grey
  highlight User2 ctermfg=grey ctermbg=18

  " user groups
  highlight User3 ctermfg=8
  highlight User4 ctermfg=19

  " plugins
  highlight LightBulbFloatWin ctermfg=3
  highlight link IndentBlankLineChar User4


  if has('nvim')
    highlight Pmenu ctermfg=7 ctermbg=19
  endif
endfunction

let g:FocusBlacklist = [
      \ '',
      \ 'fzf',
      \ 'fugitiveblame',
      \ 'nerdtree',
      \ 'qf'
      \ ]

function! me#should_focus() abort
  if !has('nvim')
    return 0
  endif
  if !exists('+colorcolumn')
    return 0
  endif
  if index(g:FocusBlacklist, bufname(bufnr('%'))) != -1
    return 0
  endif
  return index(g:FocusBlacklist, &filetype) == -1
endfunction

function! me#blur() abort
  if me#should_focus()
    let &l:colorcolumn=join(range(1, 255), ',')
    set winhighlight=Normal:User3
    ownsyntax off
  endif
endfunction

function! me#focus() abort
  if me#should_focus()
    let &l:colorcolumn='+' . join(range(0,254), ',+')
    set winhighlight=
    ownsyntax on
  endif
endfunction

function! me#plaintext() abort
  setlocal spell spelllang=en_gb
endfunction

function! me#reviewqf(commit) abort
  " Get the result of git show in a list
  " let flist = system('git show --name-only ' . commit . ' | tail -n +7')
  let flist = system('git diff --name-only $(git merge-base HEAD ' . a:commit . ')')
  let flist = split(flist, '\n')

  let list = []
  for f in flist
    let dic = {'filename': f, "lnum": 1}
    call add(list, dic)
  endfor

  " Populate the qf list
  call setqflist(list)
  copen
endfunction

function! me#set_executable_if_script(line1, current_file) abort
  if a:line1 =~ '^#!\(/usr\)*/bin/'
    let chmod_command = "silent !chmod ugo+x " . a:current_file
    execute chmod_command
  endif
endfunction

function! me#empty_reg() abort
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfunction

function! me#scratch(...) abort
  let scratch_file = "scratch"
  exe 'split /tmp/' . scratch_file
endfunction
