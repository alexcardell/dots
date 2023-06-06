lua <<EOF

local dap = require('dap')

dap.configurations.scala = {
  {
      type = 'scala',
      request = 'launch',
      name = 'Run',
      console = 'integratedTerminal',
      metals = { runType = 'run' }
  },
  {
      type = 'scala',
      request = 'launch',
      name = 'Test File',
      console = 'integratedTerminal',
      metals = { runType = 'testFile' }
  },
  {
      type = 'scala',
      request = 'launch',
      name = 'Test Target',
      console = 'integratedTerminal',
      metals = { runType = 'testTarget' }
  }
}

return dap

EOF

let g:dap_virtual_text = v:true

" dap
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>
