if has('conceal')
  setlocal concealcursor=nc
endif
if has('linebreak')
  setlocal showbreak=↘             " u-2198
endif

setlocal nolist
setlocal textwidth=0
setlocal wrap
setlocal wrapmargin=0
setlocal spell

nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> $ g$
nnoremap <buffer> ^ g^
