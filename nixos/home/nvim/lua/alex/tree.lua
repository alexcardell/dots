local key = vim.api.nvim_set_keymap

local M = {}

M.setup = function()
  require('neo-tree').setup({
    use_default_mappings = false,
    window = {
      mappings = {
        ["<space>"] = "toggle_node",
        ["o"] = "open",
        ["O"] = "open_with_window_picker",
        ["-"] = "open_split",
        ["|"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["a"] = "add",
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination
        ["m"] = "move", -- takes text input for destination
        ["q"] = "close_window",
        ["R"] = "refresh",
      }
    },
    filesystem = {
      window = {
        mappings = {
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          -- ["f"] = "filter_on_submit",
          -- ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          -- ["."] = "set_root",
        }
      },
      filtered_items = {
        hide_dotfiles = false
      }
    }
  })

  key("n", "<leader>t", "<cmd>Neotree toggle reveal=true<cr>", {})
end

return M
