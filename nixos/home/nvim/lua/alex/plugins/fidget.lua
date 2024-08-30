local M = {}

M.setup = function()
  require('fidget').setup({
    progress = { poll_rate = false },
    notification = {
      override_vim_notify = true,
      view = {
        stack_upwards = false,
      },
      window = {
        winblend = 20,
        border = "rounded",
        max_height = 6,
        align = "top"
      }
    }
  })
end

return M
