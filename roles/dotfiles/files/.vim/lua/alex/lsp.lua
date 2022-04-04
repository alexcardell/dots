local lsp_config    = require('lspconfig')
local completion = require('alex/completion')

local signature = require('lsp_signature')
local signature_config = require('alex/signature').config()

-- Disabled since it immediately clears out quickfix results (e.g. from fzf)
-- local diaglist = require('diaglist')
-- diaglist.init()

completion.setup()

local capabilities = completion.capabilities();

lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
  capabilities = capabilities,
})



-- Default on_attach
-- Could actually be function(client, bufnr) but currently unused
local on_attach = function()
  signature.on_attach(signature_config)
end

local border = "single"

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border});
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border });
}

--------------------
-- nvim-lspconfig --
--------------------

-- Dockerfile
lsp_config.dockerls.setup{
  on_attach = on_attach;
  handlers = handlers;
}

-- Haskell
lsp_config.hls.setup{
  on_attach = on_attach;
  handlers = handlers;
}

-- Java
lsp_config.jdtls.setup{
  on_attach = on_attach;
  handlers = handlers;
}

-- Typescript
lsp_config.tsserver.setup{
  on_attach = on_attach;
  handlers = handlers;
}

-- vimscript
lsp_config.vimls.setup{
  on_attach = on_attach;
  handlers = handlers;
}

-- TeX/LaTeX
lsp_config.texlab.setup{
  on_attach=on_attach;
  handlers = handlers;
  settings = {
    build = {
      executable = "tectonic";
      args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates"};
      isContinuous = false;
    };
  };
}

-- Rescript/ReasonML
lsp_config.rescriptls.setup {
  on_attach = on_attach;
  handlers = handlers;
  cmd = {
    "node",
    "/home/alex/.vim/plug/vim-rescript/server/out/server.js",
    "--stdio"
  };
  filetypes = {"rescript", "reason"};
}

-- Lua
lsp_config.sumneko_lua.setup {
  on_attach=on_attach;
  handlers = handlers;
  cmd = {
    "/home/alex/Code/vendor/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    "/home/alex/Code/vendor/lua-language-server/main.lua"
  };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- since using mainly for neovim
        path = vim.split(package.path, ';')
      },
      diagnostics = {globals = {'vim', 'it'}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}

---------------------
-- lspkind symbols --
---------------------
-- require('lspkind').init()
  --{
  --  -- enables text annotations
  --  --
  --  -- default: true
  --  with_text = true,

  --  -- default symbol map
  --  -- can be either 'default' or
  --  -- 'codicons' for codicon preset (requires vscode-codicons font installed)
  --  --
  --  -- default: 'default'
  --  preset = 'codicons',

  --  -- override preset symbols
  --  --
  --  -- default: {}
  --  symbol_map = {
  --    Text = '',
  --    Method = 'ƒ',
  --    Function = 'ﬦ',
  --    Constructor = '',
  --    Variable = '',
  --    Class = '',
  --    Interface = 'ﰮ',
  --    Module = '',
  --    Property = '',
  --    Unit = '',
  --    Value = '',
  --    Enum = '謹',
  --    Keyword = '',
  --    Snippet = '﬌',
  --    Color = '',
  --    File = '',
  --    Folder = '',
  --    EnumMember = '',
  --    Constant = '',
  --    Struct = ''
  --  },
  --}

