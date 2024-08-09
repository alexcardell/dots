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
      enable = true,
      keymaps = {
        init_selection = "<M-space>", -- set to `false` to disable mapping
        node_incremental = "<M-space>",
        scope_incremental = false,
        node_decremental = "<BS>",
        scope_decremental = false,
      },
    },
    textobjects = {
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
