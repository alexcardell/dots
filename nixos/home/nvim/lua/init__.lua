-- This module is functionally an init.lua
-- and is imported via home-manager
-- see nixos/home.nix

vim.g.mapleader = " " -- space
vim.g.maplocalleader = "\\"

require('alex/options')
require('alex/plugins/gitsigns').setup()
require('alex/keys')
