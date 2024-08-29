local M = {}

M.setup = function()
  require('fidget').setup({
    notification = {
      window = {
        winblend = 20,
        border = "rounded",
        max_height = 3
      }
    }
  })
end

return M
