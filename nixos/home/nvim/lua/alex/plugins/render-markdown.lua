local M = {}

M.setup = function()
  require('render-markdown').setup({
    file_types = { 'markdown', 'codecompanion' }
  })
end

return M
