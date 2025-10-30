local metals = require('metals')

local M = {}

local capabilities = require('alex/components/completion').capabilities

local default_on_attach = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

local setup_metals = function()
  local config = metals.bare_config()

  config.init_options = {
    statusBarProvider = "off",
    debuggingProvider = true
  }

  config.settings = {
    autoImportBuild            = "all",
    defaultBspToBuildTool      = true,
    enableSemanticHighlighting = false,
    inlayHints                 = {
      byNameParameters = { enable = true },
      hintsInPatternMatch = { enable = true },
      implicitArguments = { enable = true },
      implicitConversions = { enable = false },
      inferredTypes = { enable = true },
      typeParameters = { enable = true },
    },
    useGlobalExecutable        = true, -- for nix
    startMcpServer             = true
    -- testUserInterface          = "Test Explorer"
  }

  config.capabilities = capabilities

  config.on_attach = function(client, bufnr)
    metals.setup_dap()
    default_on_attach(client, bufnr)
  end

  -- config.handlers = -- default_handlers

  vim.api.nvim_create_autocmd('Filetype', {
    pattern = { "java", "scala", "sbt" },
    desc = 'Initialize or attach metals',
    group = vim.api.nvim_create_augroup(
      'metals',
      { clear = true }
    ),
    callback = function()
      metals.initialize_or_attach(config)
    end,
  })
end

M.setup = function()
  -- disable semantic highlights
  vim.api.nvim_create_autocmd("ColorScheme", {
    -- pattern = { "java", "scala", "sbt" },
    desc = "Disable all LSP semantic token highlights",
    group = vim.api.nvim_create_augroup(
      'DisableLspSemanticHighlights',
      { clear = true }
    ),
    callback = function()
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  })

  -- anything with standard empty configuration
  local standard_servers = {
    'nixd',
    'smithy_ls',
    'terraformls',
    'ts_ls',
    'dockerls',
    'docker_compose_language_service'
  }

  for _, server in ipairs(standard_servers) do
    vim.lsp.enable(server)
  end

  vim.lsp.config("ltex", {
    ltex = {
      language = "en-GB",
      motherTongue = "en-GB"
    },
  })
  vim.lsp.enable("ltex")

  vim.lsp.config("lua_ls", {
    Lua = {
      runtime = { version = 'LuaJIT', },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  })
  vim.lsp.enable("lua_ls")

  vim.lsp.config("yamlls", {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      }
    }
  })
  vim.lsp.enable("yamlls")

  setup_metals()
end

return M
