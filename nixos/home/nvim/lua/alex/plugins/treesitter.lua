local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
    }, 
    indent = {
      enable = true,
    }, 
    incremental_selection = {
      -- enable = true,
      -- keymaps = {
      --   init_selection = "gnn", -- set to `false` to disable mapping
      --   node_incremental = "grn",
      --   scope_incremental = "grc",
      --   node_decremental = "grm",
      --   scope_decremental = "grm",
      -- },
    },
  })
end

return M
