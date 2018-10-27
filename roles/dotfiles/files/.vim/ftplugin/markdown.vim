if has('conceal')
  let b:indentLine_ConcealOptionSet=1
  setlocal concealcursor=nc
endif
if has('linebreak')
  setlocal showbreak=↘             " u-2198
endif

setlocal nolist
setlocal textwidth=0
setlocal wrap
setlocal wrapmargin=0

nnoremap <buffer> j gj
nnoremap <buffer> k gk
