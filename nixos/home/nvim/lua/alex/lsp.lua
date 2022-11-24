local lspconfig = require('lspconfig')
local lspconfig_win = require('lspconfig.ui.windows')
local metals = require('metals')

local completion = require('alex/completion')

local on_attach = function () end

local border = "single"

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local capabilities = completion.capabilities()

-- make :LspInfo pretty
local _default_ops = lspconfig_win.default_opts
lspconfig_win.default_opts = function(options)
  local opts = _default_ops(options)
  opts.border = 'single'
  return opts
end

local M = {}

M.setup_lsp = function ()
    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
      capabilities = capabilities,
    })

    -- nix
    lspconfig.rnix.setup({
      on_attach = on_attach,
      handlers = handlers,
    })

    -- ltex -- markdown/latex
    lspconfig.ltex.setup({
      on_attach = on_attach,
      handlers = handlers,
      filetypes = { 'markdown', 'tex' },
    })

    -- lua
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    table.insert(runtime_path, "lua/?/init__.lua")
    lspconfig.sumneko_lua.setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- typescript/javascript
    lspconfig.tsserver.setup({
      on_attach = on_attach,
      handlers = handlers,
    })

    -- -- tailwindcss
    -- lspconfig.tailwindcss.setup({
    --   on_attach = on_attach,
    --   handlers = handlers,
    -- })
  end

M.metals = metals.bare_config()

M.metals.on_attach = on_attach
M.metals.handlers = handlers

M.metals.init_options = {
     statusBarProvider            = "off",
     inputBoxProvider             = true,
     quickPickProvider            = true,
     executeClientCommandProvider = true,
     decorationProvider           = true,
     didFocusProvider             = true,
     debuggingProvider            = true,
   }

M.metals.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    useGlobalExecutable = true, -- for nix
}

M.metals.capabilities = capabilities

return M
