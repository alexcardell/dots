local M = {}

M.setup = function()
  require('render-markdown').setup({
    file_types = { 'markdown', 'codecompanion', "AgenticChat" }
  })
end

return M
