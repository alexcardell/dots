local key = vim.api.nvim_set_keymap

local M = {}

M.setup = function()

  require("nvim-tree").setup({
    view = {
      mappings = {
        custom_only = true,
        list = {
          -- :help nvim-tree-default-mappings
          { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
          { key = { "<C-v>" }, action = "vsplit" },
          { key = { "<C-x>" }, action = "split" },
          { key = { "<C-t>" }, action = "tabnew" },
          { key = { "R" }, action = "refresh" },
          { key = { "a" }, action = "create" },
          { key = { "d" }, action = "remove" },
          { key = { "r" }, action = "rename" },
          { key = { "-" }, action = "dir_up" },
          { key = { "\\[" }, action = "prev_diag_item" },
          { key = { "\\]" }, action = "next_diag_item" },
          { key = { "[c" }, action = "prev_git_item" },
          { key = { "]c" }, action = "next_git_item" },
          { key = { "K" }, action = "prev_sibling" },
          { key = { "J" }, action = "next_sibling" },
          { key = { "H" }, action = "toggle_dotfiles" },
          { key = "g?", action = "toggle_help" },
        }
      }
    }
  })

  key("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
  key("n", "<leader>T", "<cmd>NvimTreeFindFile<cr>", {})
end

return M
