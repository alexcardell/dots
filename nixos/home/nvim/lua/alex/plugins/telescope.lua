local telescope = require('telescope')

local M = {}

M.setup = function()
  telescope.setup({
    defaults = {
      path_display = { "truncate" }
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  })

  -- load extensions
  pcall(telescope.load_extension, 'ui-select')
end

return M
