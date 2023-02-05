local dap = require('dap')

local M = {}

M.setup = function()
  vim.g.dap_virtual_text = true

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
end

return M
