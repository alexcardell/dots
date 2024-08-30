local M = {}

local ollama_model = "llama3.1:latest"

local setup_avante = function()
  require('render-markdown').setup({
    file_types = { 'markdown', 'Avante' }
  })
  require('avante').setup({
    provider = "ollama", -- "claude"
    windows = {
      wrap = true,
      sidebar_header = {
        rounded = false
      }
    },
    hints = { enabled = true },
    vendors = {
      ["ollama"] = {
        ["local"] = true,
        endpoint = "127.0.0.1:11434/v1",
        model = ollama_model,
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. "/chat/completions",
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
            },
            body = {
              model = opts.model,
              -- you can make your own message, but this is very advanced
              messages = require("avante.providers").copilot.parse_message(code_opts),
              max_tokens = 2048,
              stream = true,
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      }
    }
  })
end

local setup_codecompanion = function()
  require('codecompanion').setup({
    adapters = {
      ollama = require('codecompanion.adapters').extend("ollama", {
        schema = { model = { default = ollama_model } }
      })
    },
    strategies = {
      chat = {
        adapter = "ollama",
      },
      inline = {
        adapter = "ollama",
      },
      agent = {
        adapter = "ollama",
      },
    },
  })
end

M.setup = function()
  setup_codecompanion()
  setup_avante()
end

return M
