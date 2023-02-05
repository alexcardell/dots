local key = vim.api.nvim_set_keymap

local M = {}

M.setup = function()

  require("nvim-tree").setup({
    view = {
      mappings = {
        custom_only = true,
        list = {
          { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
          { key = "g?", action = "toggle_help" },
        }
      }
    }
  })

  key("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
  key("n", "<leader>T", "<cmd>NvimTreeFindFile<cr>", {})
end

return M
