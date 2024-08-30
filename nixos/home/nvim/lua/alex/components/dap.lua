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
end

return M
