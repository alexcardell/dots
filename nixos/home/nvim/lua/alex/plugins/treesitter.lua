local M = {}

M.setup = function()
  -- Treesitter highlight/indent now use native Neovim APIs (auto-enabled with parsers)
  -- Parsers are managed via Nix in nvim.nix

  -- Textobjects (nvim-treesitter-textobjects plugin)
  require('nvim-treesitter-textobjects').setup({
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@assignment.outer",
        ["ia"] = "@assignment.inner",
        ["al"] = "@assignment.lhs",
        ["ar"] = "@assignment.rhs",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = { query = "@scope", query_group = "locals" },
      },
    },
  })

  -- Incremental selection (via treesitter-modules.nvim)
  require('treesitter-modules').setup({
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-space>",
        node_incremental = "<M-space>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  })

  require('nvim-ts-autotag').setup({
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false -- Auto close on trailing </
    },
  })

  require("nvim-autopairs").setup({
    check_ts = true,
    -- ts_config = {
    --   lua = {'string'},-- it will not add a pair on that treesitter node
    --   java = false,-- don't check treesitter on java
    -- }
  })

end

return M
