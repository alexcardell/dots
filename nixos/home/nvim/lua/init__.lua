-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

vim.opt_global.shortmess:remove("F") -- required by metals

-- buffer management
vim.g.hidden = true
vim.opt.switchbuf = "usetab"
vim.opt.autoread = true

-- visual
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:2"

-- commands
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }

-- editing
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- nvim-cmp
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.spelllang = "en_gb,en"
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.scrolloff = 3
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.sidescrolloff = 3
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.virtualedit = "block"
vim.opt.splitbelow = true
vim.opt.splitright = true

local key = vim.api.nvim_set_keymap

-- basic mappings
key("i", "jk", "<Esc>", {})
-- toggle last buffer
key("n", "<leader><leader>", "<C-^>", {})
-- quickfix navigation
key("n", "gn", "<cmd>cnext<cr>", {})
key("n", "gp", "<cmd>cprevious<cr>", {})
key("n", "g1", "<cmd>cfirst<cr>", {})
key("n", "g0", "<cmd>clast<cr>", {})
key("n", "g<", "<cmd>colder<cr>", {})
key("n", "g>", "<cmd>cnewer<cr>", {})

require('alex/completion').setup()
require('alex/lsp').setup_lsp()
require('alex/dap').setup()
require('alex/statusline').setup()
require('alex/tree').setup()

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
key("n", "<localleader>f", "<cmd>lua vim.lsp.buf.format()<cr>", {})

key("n", "<localleader>mb", "<cmd>MetalsImportBuild<cr>", {})

-- Diaglist
key("n", "<localleader>x", "<cmd>lua require('diaglist').open_all_diagnostics()<cr>", {})
key("n", "<localleader>X", "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>", {})

-- Telescope
key("n", "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", {})
key("n", "<leader>f/", "<cmd>Telescope live_grep<cr>", {})
key("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
key("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
key("n", "<leader>fc", "<cmd>Telescope commands<cr>", {})
key("n", "<leader>fm", "<cmd>Telescope marks<cr>", {})
key("n", "<leader>fp", "<cmd>Telescope registers<cr>", {})
key("n", "<leader>fx", "<cmd>Telescope diagnostics<cr>", {})
key("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})
key("n", "<localleader>mc", [[  lua require("telescope").extensions.metals.commands() ]], {})

-- tmux integration
require('Navigator').setup({})
key('n', "<C-h>", '<CMD>NavigatorLeft<CR>', {})
key('n', "<C-l>", '<CMD>NavigatorRight<CR>', {})
key('n', "<C-k>", '<CMD>NavigatorUp<CR>', {})
key('n', "<C-j>", '<CMD>NavigatorDown<CR>', {})

-- Tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- colorscheme
require('base16-colorscheme').with_config({
  telescope = false,
  indentblankline = false,
  notify = false,
  ts_rainbow = false,
  illuminate = false,
  cmp = false
})

vim.cmd([[ colorscheme base16-tomorrow-night ]])

local zk = require('zk')
local zk_cmds = require('zk.commands')

zk.setup({ picker = 'telescope' })

zk_cmds.add("ZkDaily", function(options)
  options = vim.tbl_extend("force", { dir = "journal/daily" }, options or {})
  zk.new(options)
end)

require('gitsigns').setup()
key("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", {})
key("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", {})
key("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", {})
key("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", {})
key("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", {})
key("n", "]c", '&diff ? "]c" : "<cmd>Gitsigns next_hunk<cr>"', { expr = true })
key("n", "[c", '&diff ? "[c" : "<cmd>Gitsigns prev_hunk<cr>"', { expr = true })
key("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", {})
key("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", {})

require('tint').setup({})

require('zen-mode').setup()

require('other-nvim').setup({
  mappings = {
    -- sbt src -> test
    {
      pattern = "/src/main/scala/(.*)/(.*).scala",
      target = "/src/test/scala/%1/%2Test.scala",
      context = "test"
    },
    -- sbt src -> it:test
    {
      pattern = "/src/main/scala/(.*)/(.*).scala",
      target = "/src/it/scala/%1/%2Test.scala",
      context = "it-test"
    },
    -- sbt test -> src
    {
      pattern = "/src/test/scala/(.*)/(.*)Test.scala",
      target = "/src/main/scala/%1/%2.scala",
      context = "main"
    },
    -- sbt it:test -> src
    {
      pattern = "/src/it/scala/(.*)/(.*)Test.scala",
      target = "/src/main/scala/%1/%2.scala",
      context = "main"
    },
    -- mill src -> test
    {
      pattern = "/src/(.*)/(.*).scala",
      target = "/test/src/%1/%2Test.scala",
      context = "test"
    },
    -- mill src -> it:test
    {
      pattern = "/src/(.*)/(.*).scala",
      target = "/it/src/%1/%2Test.scala",
      context = "test"
    },
    -- mill test -> src
    {
      pattern = "/test/src/(.*)/(.*)Test.scala",
      target = "/src/%1/%2.scala",
      context = "main"
    },
    -- mill it:test -> src
    {
      pattern = "/it/src/(.*)/(.*)Test.scala",
      target = "/src/%1/%2.scala",
      context = "main"
    },
  },
})
key("n", "<leader>of", "<cmd>Other<cr>", {})
key("n", "<leader>os", "<cmd>OtherSplit<cr>", {})
key("n", "<leader>ov", "<cmd>OtherVSplit<cr>", {})

-- require('nvim-autopairs').setup()

require('nvim-treesitter.configs').setup({
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = true
  }
  -- autotag = {
  --   enable = true,
  -- }
})

-- require('aerial').setup()
-- key("n", "<leader>os", "<cmd>AerialToggle<cr>", {})

require("symbols-outline").setup()
key("n", "<leader>o", "<cmd>SymbolsOutline<cr>", {})
vim.cmd([[
  augroup symboloutlineau
    au!
    au FileType Outline setlocal signcolumn=no
  augroup end
]])

-- require('edgy').setup({
--   left = {
--     {
--       title = "Files",
--       ft = "NvimTree",
--       pinned = true,
--     },
--     {
--       title = "Symbols",
--       ft = "Outline",
--       pinned = true,
--       open = "SymbolsOutline",
--     },
--   }
-- })
