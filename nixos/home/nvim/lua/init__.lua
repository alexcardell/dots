-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"
vim.g.hidden = true
vim.opt_global.shortmess:remove("F") -- required by metals
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.switchbuf = "usetab"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.inccommand = "nosplit"
vim.opt.autoread = true
vim.opt.incsearch = true
vim.opt.confirm = true
vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes:2"
vim.opt.expandtab = true

local key = vim.api.nvim_set_keymap

key("i", "jk", "<Esc>", {})

require('alex/statusline').setup()

-- LSP
local completion = require('alex/completion')
local lsp = require('alex/lsp')

completion.setup()
lsp.setup_lsp()

-- metals autocmd
vim.cmd([[
  augroup lsp
    au!
    au FileType java,scala,sbt lua require("metals").initialize_or_attach(require('alex/lsp').metals)
  augroup end
]])

key("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
key("n", "<localleader>t", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {})
key("n", "<localleader>h", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
key("n", "<localleader>H", "<cmd>lua vim.diagnostic.open_float()<cr>", {})
key("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
key("n", "<localleader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
key("n", "<localleader>r", "<cmd>lua vim.lsp.buf.references()<cr>", {})
key("n", "<localleader>c", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
key("n", "<localleader>l", "<cmd>lua vim.lsp.codelens.run()<cr>", {})
key("n", "<localleader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", {})

-- Telescope
key("n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", {})
key("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", {})
key("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
key("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
key("n", "<leader>fc", "<cmd>Telescope commands<cr>", {})
key("n", "<leader>fm", "<cmd>Telescope marks<cr>", {})
key("n", "<leader>fp", "<cmd>Telescope registers<cr>", {})


-- tmux integration
require('Navigator').setup()
key('n', "<C-h>", '<CMD>NavigatorLeft<CR>', {})
key('n', "<C-l>", '<CMD>NavigatorRight<CR>', {})
key('n', "<C-k>", '<CMD>NavigatorUp<CR>', {})
key('n', "<C-j>", '<CMD>NavigatorDown<CR>', {})

-- Tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.fn.sign_define( "DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define( "DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define( "DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define( "DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

require('neo-tree').setup({
  use_default_mappings = false,
  window = {
    mappings = {
      ["<space>"] = "toggle_node",
      ["o"] = "open",
      ["O"] = "open_with_window_picker",
      ["-"] = "open_split",
      ["|"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["a"] = "add",
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination
      ["m"] = "move", -- takes text input for destination
      ["q"] = "close_window",
      ["R"] = "refresh",
    }
  },
  filesystem = {
    window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        -- ["f"] = "filter_on_submit",
        -- ["<C-x>"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        -- ["."] = "set_root",
      }
    },
    filtered_items = {
      hide_dotfiles = false
    }
  }
})

key("n", "<leader>t", "<cmd>Neotree toggle reveal=true<cr>", {})
