local telescope = require('telescope')

local M = {}

M.setup = function()
  telescope.setup({
    defaults = {
      path_display = { "truncate" },
      preview = {
        treesitter = true
      },
      vimgrep_arguments = {
        -- all required except `--smart-case`
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden"
        '--glob=!.git/*',  -- exclude .git directory
      }
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
