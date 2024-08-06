local key = vim.keymap.set

key('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

key('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', {desc = 'Stage hunk under cursor'})
key('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', {desc = 'Undo staging hunk'})
key({'n','v'}, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', {desc = 'Reset hunk under cursor'})
key('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', {desc = 'Preview hunk under cursor in popup window'})
key('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", {desc='Move to next hunk', expr = true })
key('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", {desc='Move to next hunk', expr = true })
key({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc='Select hunk as text object'})
