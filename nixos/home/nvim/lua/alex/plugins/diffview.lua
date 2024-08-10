local M = {}

M.setup = function()
  require('diffview').setup({
    keymaps = {
      disable_defaults = true,
    }
  })

  vim.api.nvim_create_user_command(
    'DiffReview',
    'DiffviewOpen origin/HEAD...HEAD --imply-local',
    {}
  )
end

return M
