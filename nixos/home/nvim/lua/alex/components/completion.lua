local M = {}

M.setup_blink = function()
  local blink = require('blink.cmp')
  local luasnip = require('luasnip')

  blink.setup({
    keymap = { preset = 'super-tab' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = { enabled = true},
    snippets = {
      expand = function(snippet) luasnip.lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return luasnip.jumpable(filter.direction)
        end
        return luasnip.in_snippet()
      end,
      jump = function(direction) luasnip.jump(direction) end,
    }
  })
end

M.setup_cmp = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup({
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-c>'] = cmp.mapping.abort(),
      -- pop up completion window
      ['<C-Space>'] = cmp.mapping.complete(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping.confirm({ select = true, behavior = 'replace' }),
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50
      })
    }
  })

  cmp.setup.filetype('sql', {
    sources = cmp.config.sources({
      { name = 'vim-dadbod-completion' }
    }, {
      { name = 'buffer' },
    })
  })

  require('cmp_git').setup()

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('lua', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lua' }
    }, {
      { name = 'buffer' }
    })
  })

  cmp.setup.filetype({
    "dap-repl", "dapui_watches", "dapui_hover"
  }, {
    sources = cmp.config.sources({
      { name = "dap" }
    })
  })
end

M.capabilities = require('blink.cmp').get_lsp_capabilities()
-- M.capabilities = require('cmp_nvim_lsp').default_capabilities()

M.setup = M.setup_blink

return M
