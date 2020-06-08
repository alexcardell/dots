command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {
        \ 'options': [
        \ '--inline-info',
        \ '--preview',
        \ '~/.vim/pack/bundle/start/fzf.vim/bin/preview.sh {}'
        \ ]}, <bang>0)

nnoremap <leader>fa :Files<CR>

nnoremap <localleader>/ :Rg<Space>

nnoremap <leader>fb :Buffers<CR>

nnoremap <leader>fl :Lines<CR>

nnoremap <leader>f/ :BLines<CR>

nnoremap <leader>fh :Helptags<CR>

nnoremap <leader>fs :Snippets<CR>

function! s:yank_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @+ = joined_lines
endfunction

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-y': function('s:yank_results'),
      \ }
