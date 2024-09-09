local M = {}

M.setup = function()
  local lint = require('lint')

  lint.linters_by_ft = {
    sh = { 'shellcheck' },
    zsh = { 'shellcheck' },
    bash = { 'shellcheck' },
    yaml = { 'actionlint', 'yamllint' }
  }

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    desc = 'Lint on save',
    group = vim.api.nvim_create_augroup(
      'nvim-lint',
      { clear = true }
    ),
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
