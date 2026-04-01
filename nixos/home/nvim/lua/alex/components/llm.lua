local M = {}

local setup_agentic = function()
  -- if mac assume we're on the work machine
  local is_mac = vim.fn.has("macunix") == 1
  if is_mac then
    require('agentic').setup({
      provider = "copilot-acp"
    })
  else
    require('agentic').setup({
      provider = "mistral-vibe-acp"
    })
  end
end

M.setup = function()
  setup_agentic()
end

return M
