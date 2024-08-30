local M = {}

M.setup = function()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<C-Space>'] = cmp.mapping.complete(),                                   -- pop up completion window
      ['<Tab>'] = cmp.mapping.confirm({ select = true, behavior = 'replace' }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }),
  })
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
