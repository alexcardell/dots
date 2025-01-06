local M = {}

local setup_autocmds = function()
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup(
      'trim_whitespace',
      { clear = true }
    ),
    pattern = "*",
    desc = 'Trim whitespace on save',
    callback = function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[%s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, cursor)
    end,
  })
end

M.setup = setup_autocmds

return M
