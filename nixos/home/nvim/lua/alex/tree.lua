local key = vim.api.nvim_set_keymap

local M = {}

-- Generated from 'NvimTreeGenerateOnAttach'
local function tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings not inserted as:
  --  remove_keymaps = true
  --  OR
  --  view.mappings.custom_only = true


  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  -- vim.keymap.set('n', '\[', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  -- vim.keymap.set('n', '\]', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
end

M.setup = function()
  require("nvim-tree").setup({
    on_attach = tree_on_attach
  })

  key("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
  key("n", "<leader>T", "<cmd>NvimTreeFindFileToggle<cr>", {})
end

return M
