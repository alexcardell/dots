local key = vim.keymap.set

key("i", "jk", "<Esc>", {desc = 'Exit insert mode'})
key("n", "<leader><leader>", "<C-^>", {desc = 'Toggle last buffer'})
key('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- gitsigns
key('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', {desc = 'Stage hunk under cursor'})
key('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', {desc = 'Undo staging hunk'})
key({'n','v'}, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', {desc = 'Reset hunk under cursor'})
key('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', {desc = 'Preview hunk under cursor in popup window'})
key('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", {desc='Move to next hunk', expr = true })
key('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", {desc='Move to next hunk', expr = true })
key({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc='Select hunk as text object'})

-- Telescope
key("n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", {})
key("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", {})
key("n", "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_fine<cr>", {})
key("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
key("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
key("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", {})
key("n", "<leader>ff", "<cmd>Telescope builtin<cr>", {})
key("n", "<leader>fc", "<cmd>Telescope commands<cr>", {})
key("n", "<leader>fm", "<cmd>Telescope marks<cr>", {})
key("n", "<leader>fr", "<cmd>Telescope registers<cr>", {})
key("n", "<leader>fx", "<cmd>Telescope diagnostics<cr>", {})
key("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})
-- key("n", "<localleader>mc", [[  lua require("telescope").extensions.metals.commands() ]], {})

-- Navigator
key("n", "<C-h>", "<cmd>NavigatorLeft<cr>", {})
key("n", "<C-l>", "<cmd>NavigatorRight<cr>", {})
key("n", "<C-k>", "<cmd>NavigatorUp<cr>", {})
key("n", "<C-j>", "<cmd>NavigatorDown<cr>", {})

-- Oil.nvim
key("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
