local M = {}

M.setup = function()
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
      { name = 'vim-dadbod-completion' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })

  -- cmp.setup.filetype({
  --   "dap-repl", "dapui_watches", "dapui_hover"
  -- }, {
  --   sources = {
  --     "dap"
  --   }
  -- })
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
