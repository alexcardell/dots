-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

-- settings
require('alex/options')

-- core plugins
require('alex/plugins/treesitter').setup()
require('alex/plugins/telescope').setup()
require('alex/plugins/base16').setup()

-- aggregate components
require('alex/components/lsp').setup()
require('alex/components/llm').setup()
require('alex/components/completion').setup()

-- other plugins
require('alex/plugins/gitsigns').setup()
require('alex/plugins/diffview').setup()
require('alex/plugins/navigator').setup()
require('alex/plugins/oil').setup()
require('alex/plugins/other').setup()
require('alex/plugins/hardtime').setup()
require('alex/plugins/fidget').setup()
require('alex/plugins/indent-blankline').setup()
require('alex/plugins/tint').setup()

require('alex/plugins/lualine').setup()

-- keymappings
require('alex/keys')
