let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
      \'path': $HOME . '/wiki',
      \'syntax': 'markdown',
      \'ext': '.md',
      \'auto_toc': 1,
      \'auto_tags': 1,
      \}]


call vimwiki#vars#init()
