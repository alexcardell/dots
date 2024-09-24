local M = {}

M.setup = function()
  require('quicker').setup({
    opts = {
      buflisted = false,
      number = true,
      relativenumber = true,
      signcolumn = "auto",
      winfixheight = true,
      wrap = false,
    }
  })
end

return M
