local telescope = require('telescope')

local M = {}

M.setup = function()
  telescope.setup({
    defaults = {
      path_display = { "truncate" },
      preview = {
        treesitter = true
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  })

  -- load extensions
  pcall(telescope.load_extension, 'ui-select')
  pcall(telescope.load_extension, 'dap')
end

return M
