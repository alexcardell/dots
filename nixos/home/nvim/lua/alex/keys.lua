local key = function(modes, l, r, opts)
  opts = opts or {}
  vim.keymap.set(modes, l, r, opts)
end

key("i", "jk", "<Esc>", { desc = 'Exit insert mode' })
key("n", "<leader><leader>", "<C-^>", { desc = 'Toggle last buffer' })
key('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- gitsigns
key('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', { desc = 'Stage hunk under cursor' })
key('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', { desc = 'Undo staging hunk' })
key({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'Reset hunk under cursor' })
key('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'Preview hunk under cursor in popup window' })
key('n', ']c', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Move to next hunk' })
key('n', '[c', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Move to next hunk' })
key({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk as text object' })

-- Telescope
key("n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>")
key("n", "<leader>f/", "<cmd>Telescope live_grep<cr>")
key("n", "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_fine<cr>")
key("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
key("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
key("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
key("n", "<leader>ff", "<cmd>Telescope builtin<cr>")
key("n", "<leader>fc", "<cmd>Telescope commands<cr>")
key("n", "<leader>fm", "<cmd>Telescope marks<cr>")
key("n", "<leader>fr", "<cmd>Telescope registers<cr>")
key("n", "<leader>fx", "<cmd>Telescope diagnostics<cr>")
key("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
-- key("n", "<localleader>mc", [[  lua require("telescope").extensions.metals.commands() ]])

-- Navigator
key("n", "<C-h>", "<cmd>NavigatorLeft<cr>")
key("n", "<C-l>", "<cmd>NavigatorRight<cr>")
key("n", "<C-k>", "<cmd>NavigatorUp<cr>")
key("n", "<C-j>", "<cmd>NavigatorDown<cr>")

-- Oil.nvim
key("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- LSP
key("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>")
key("n", "<localleader>t", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
key("n", "<localleader>h", "<cmd>lua vim.lsp.buf.hover()<cr>")
key("n", "<localleader>H", "<cmd>lua vim.diagnostic.open_float()<cr>")
key("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>")
key("n", "<localleader>R", "<cmd>lua vim.lsp.buf.rename()<cr>")
key("n", "<localleader>r", "<cmd>lua vim.lsp.buf.references()<cr>")
key("n", "<localleader>c", "<cmd>lua vim.lsp.buf.code_action()<cr>")
key("n", "<localleader>l", "<cmd>lua vim.lsp.codelens.run()<cr>")
key("n", "<localleader>f", "<cmd>lua vim.lsp.buf.format()<cr>")
key("n", "<localleader>x", "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})<cr>")
key("n", "<localleader>X", "<cmd>lua vim.diagnostic.setqflist()<cr>")
key("n", "<localleader>z", "<cmd>lua vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR})<cr>")
key("n", "<localleader>Z", "<cmd>lua vim.diagnostic.setloclist()<cr>")
key("n", "<localleader>]", "<cmd>lua vim.diagnostic.goto_next()<cr>")
key("n", "<localleader>[", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

key("n", "<localleader>mb", "<cmd>MetalsImportBuild<cr>")

-- quickfix
key("n", "gn", ":cnext<cr>", { desc = "Next quickfix item" })
key("n", "gp", ":cprevious<cr>", { desc = "Previous quickfix item" })

-- other-nvim
key("n", "<leader>of", "<cmd>Other<cr>")
key("n", "<leader>os", "<cmd>OtherSplit<cr>")
key("n", "<leader>ov", "<cmd>OtherVSplit<cr>")

-- luasnip
local luasnip = require('luasnip')
key("i", "<C-j>", function() luasnip.jump(1) end, { desc = "Next luasnip tabstop", silent = true })
key("i", "<C-k>", function() luasnip.jump(-1) end, { desc = "Previous luasnip tabstop", silent = true })

-- outline
key("n", "<leader>O", "<cmd>Outline<cr>", { desc = "Toggle Outline" })

-- undotree
key("n", "<leader>U", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- dap
key('n', '<F5>', function() require('dap').continue() end, { desc = "DAP: Continue" })
key('n', '<F10>', function() require('dap').step_over() end, { desc = "DAP: Step over" })
key('n', '<F11>', function() require('dap').step_into() end, { desc = "DAP: Step into" })
key('n', '<F12>', function() require('dap').step_out() end, { desc = "DAP: Step out" })
key('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
key('n', '<leader>dl', function() require('dap').run_last() end, { desc = "DAP: Run last" })
key('n', '<leader>dd', function() require('dapui').toggle() end, { desc = "DAP: Toggle DAP UI" })
