local M = {}

M.setup = function()
  require('diffview').setup({
    keymaps = {
      disable_defaults = true,
    }
  })
end

return M
