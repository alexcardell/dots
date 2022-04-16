-- This module is functionally an init.lua
-- and is imported via home-manager 
-- see nixos/home.nix

vim.opt.hidden = true
vim.opt_global.shortmess:remove("F") -- required by metals

local completion = require('completion')
local lsp = require('lsp')

completion.setup()
lsp.setup_lsp()

vim.cmd [[
  augroup lsp
    au!
    au FileType java,scala,sbt lua require("metals").initialize_or_attach(require('lsp').metals)
  augroup end
]]
