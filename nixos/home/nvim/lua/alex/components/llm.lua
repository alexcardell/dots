local M = {}

local ollama_model = "deepseek-r1:8b"

local setup_codecompanion = function()
  local ollama_adapter = require('codecompanion.adapters').extend("ollama", {
    schema = { model = { default = ollama_model } }
  })

  require('codecompanion').setup({
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN"),
            },
          })
        end,
      },
      http = {
        ollama = ollama_adapter
      }
    },
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
      agent = {
        adapter = "copilot",
      },
    },
    extensions = {
      history = {
        enabled = true
      },
      spinner = {}
    }
  })
end

M.setup = function()
  -- setup_codecompanion()
  -- setup_avante()
end

return M
