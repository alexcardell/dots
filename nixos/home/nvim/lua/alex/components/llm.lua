local M = {}

local ollama_model = "deepseek-r1:8b"

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

  -- local colours = require('alex/plugins/base16').colours

  vim.api.nvim_set_hl(0, 'AvanteTitle', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'AvanteSubtitle', { link = 'Comment' })
  vim.api.nvim_set_hl(0, 'AvanteThirdTitle', { link = 'Comment' })
end

local setup_codecompanion = function()
  local ollama_adapter = require('codecompanion.adapters').extend("ollama", {
    schema = { model = { default = ollama_model } }
  })

  require('codecompanion').setup({
    adapters = {
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
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      },
      spinner = {}
    }
  })
end

local setup_mcphub = function()
  require('mcphub').setup({ port = 37373 })
end

M.setup = function()
  setup_mcphub()
  setup_codecompanion()
  -- setup_avante()
end

return M
