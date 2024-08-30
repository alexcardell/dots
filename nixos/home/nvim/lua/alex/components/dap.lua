local M = {}

M.setup = function()
  local dap = require('dap')

  dap.configurations.scala = {
    {
      type = 'scala',
      request = 'launch',
      name = 'Run',
      console = 'integratedTerminal',
      metals = { runType = 'run' }
    },
    {
      type = 'scala',
      request = 'launch',
      name = 'Test File',
      console = 'integratedTerminal',
      metals = { runType = 'testFile' }
    },
    {
      type = 'scala',
      request = 'launch',
      name = 'Test Target',
      console = 'integratedTerminal',
      metals = { runType = 'testTarget' }
    }
  }

  require('nvim-dap-virtual-text').setup({
    enabled = true,
    all_references = false,
    virt_text_pos = 'eol', -- 'inline'
  })

  require('dapui').setup()

  local colours = require('alex/plugins/base16').colours

  vim.api.nvim_set_hl(0, 'CustomDapBreakpoint', { fg = colours.red })
  vim.api.nvim_set_hl(0, 'CustomDapBreakpointRejected', { fg = colours.orange })

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'CustomDapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'CustomDapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'CustomDapBreakpoint' })
  vim.fn.sign_define('DapBreakpointUnsupported', { text = '', texthl = 'CustomDapBreakpointRejected' })
  vim.fn.sign_define('DapBreakpointStopped', { text = '', texthl = 'Comment' })
end

return M
