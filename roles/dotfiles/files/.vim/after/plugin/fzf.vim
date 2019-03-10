" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
endif

nnoremap <leader>fa :Files<CR>
nnoremap <leader>FA :Files!<CR>

nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>FB :Buffers!<CR>

nnoremap <leader>fl :Lines<CR>
nnoremap <leader>FL :Lines!<CR>

nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>FL :Helptags!<CR>

nnoremap <leader>fr :Rg<CR>
nnoremap <leader>FR :Rg!<CR>
