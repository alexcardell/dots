local M = {}

M.setup = function()
  -- Declare a global function to retrieve the current directory
  function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
      return vim.fn.fnamemodify(dir, ":~")
    else
      -- If there is no current directory (e.g. over ssh), just show the buffer name
      return vim.api.nvim_buf_get_name(0)
    end
  end

  require("oil").setup({
    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
    view_options = {
      show_hidden = true
    }
  })
end

return M
