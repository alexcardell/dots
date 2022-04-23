-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

local key = vim.api.nvim_set_keymap
key("i", "jk", "<Esc>", {})

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

vim.fn.sign_define( "DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define( "DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define( "DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define( "DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

require('neo-tree').setup({
  use_default_mappings = false,
  window = {
    mappings = {}
  }
})

key("n", "<leader>t", "<cmd>Neotree toggle reveal=true<cr>", {})

-- Telescope
key("n", "<leader>fa", "<cmd>Telescope find_files<cr>", {})
key("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", {})
key("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
key("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
key("n", "<leader>fc", "<cmd>Telescope commands<cr>", {})
key("n", "<leader>fm", "<cmd>Telescope marks<cr>", {})
key("n", "<leader>fp", "<cmd>Telescope registers<cr>", {})

-- LSP
key("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
key("n", "<localleader>t", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {})
key("n", "<localleader>h", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
key("n", "<localleader>H", "<cmd>lua vim.diagnostic.open_float()<cr>", {})
key("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
key("n", "<localleader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
key("n", "<localleader>r", "<cmd>lua vim.lsp.buf.references()<cr>", {})
key("n", "<localleader>c", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
key("n", "<localleader>l", "<cmd>lua vim.lsp.codelens.run()<cr>", {})

-- tmux integration
require('Navigator').setup()
key('n', "<C-h>", '<CMD>NavigatorLeft<CR>', {})
key('n', "<C-l>", '<CMD>NavigatorRight<CR>', {})
key('n', "<C-k>", '<CMD>NavigatorUp<CR>', {})
key('n', "<C-j>", '<CMD>NavigatorDown<CR>', {})
