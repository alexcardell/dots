-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

vim.g.hidden = true
vim.opt_global.shortmess:remove("F") -- required by metals

local completion = require('alex/completion')
local lsp = require('alex/lsp')

completion.setup()
lsp.setup_lsp()

vim.cmd([[
  augroup lsp
    au!
    au FileType java,scala,sbt lua require("metals").initialize_or_attach(require('alex/lsp').metals)
  augroup end
]])

-- Tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- TODO config
-- require('neo-tree').setup()

vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>Telescope find_files<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fp", "<cmd>Telescope registers<cr>", {})

vim.api.nvim_set_keymap("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>t", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>h", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>H", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>r", "<cmd>lua vim.lsp.buf.references()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>c", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
vim.api.nvim_set_keymap("n", "<localleader>l", "<cmd>lua vim.lsp.codelens.run()<cr>", {})
