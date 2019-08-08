" ripgrep
" if executable('rg')
"   set grepprg=rg\ --vimgrep
"   command! -bang -nargs=* Rg
"     \ call fzf#vim#grep(
"     \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"     \   <bang>0 ? fzf#vim#with_preview('up:60%')
"     \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"     \   <bang>0)
" endif

nnoremap <localleader>/ :Files<CR>

nnoremap <leader>/ :Rg<Space>

nnoremap <leader>fb :Buffers<CR>

nnoremap <leader>fl :Lines<CR>

nnoremap <leader>f/ :BLines<CR>

nnoremap <leader>fh :Helptags<CR>

nnoremap <leader>fs :Snippets<CR>
