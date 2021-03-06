local lsp    = require'lspconfig'
local comp   = require'completion'

-- Default on_attach
-- Could actually be function(client, bufnr) but currently unused
local on_attach = function()
  comp.on_attach()
end

--------------------
-- nvim-lspconfig --
--------------------

-- Angular
lsp.angularls.setup{on_attach=on_attach}

-- Dockerfile
lsp.dockerls.setup{on_attach=on_attach}

-- Haskell
lsp.hls.setup{on_attach=on_attach}

-- Java
lsp.jdtls.setup{on_attach=on_attach}

-- Typescript
lsp.tsserver.setup{on_attach=on_attach}

-- vimscript
lsp.vimls.setup{on_attach=on_attach}

-- TeX/LaTeX
lsp.texlab.setup{
  on_attach=on_attach;
  settings = {
    build = {
      executable = "tectonic";
      args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates"};
      isContinuous = false;
    };
  };
}

-- Rescript/ReasonML
lsp.rescriptls.setup {
  on_attach = on_attach;
  cmd = {
    "node",
    "/home/alex/.vim/plug/vim-rescript/server/out/server.js",
    "--stdio"
  };
  filetypes = {"rescript", "reason"};
}

-- Lua
lsp.sumneko_lua.setup {
  on_attach=on_attach;
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
require('lspkind').init(
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
)

-------------------
-- lsp_signature --
-------------------
-- require('lsp_signature').on_attach({
--   bind = true,
--   floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--   fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
--   hint_enable = true, -- virtual hint enable
--   hint_prefix = "a",  -- Panda for parameter
--   hint_scheme = "String",
--   use_lspsaga = false,  -- set to true if you want to use lspsaga popup
--   hi_parameter = "Search", -- how your parameter will be highlight
--   max_height = 12,
--   max_width = 120,
--   handler_opts = {
--     border = "single"   -- double, single, shadow, none
--   },
--   extra_trigger_chars = {"(", ","}
-- })
