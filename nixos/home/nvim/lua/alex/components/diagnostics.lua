local M = {}

local signs_config = {
  text = {
    [vim.diagnostic.severity.ERROR] = '',
    [vim.diagnostic.severity.WARN] = '',
    [vim.diagnostic.severity.HINT] = '',
    [vim.diagnostic.severity.INFO] = '',
  }
}

local setup = function()
  vim.diagnostic.config({
    signs = signs_config,
    virtual_text = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
  })
end

M.setup = setup

return M
