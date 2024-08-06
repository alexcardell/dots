-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

require('alex/options')
require('alex/plugins/treesitter').setup()
require('alex/plugins/telescope').setup()
require('alex/plugins/gitsigns').setup()
require('alex/plugins/navigator').setup()
require('alex/keys')
