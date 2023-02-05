local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local M = {}

M.setup = function()
  cmp.setup({
    sources = {
      { name = 'nvim_lsp' },
      -- { name = 'buffer' },
      { name = 'luasnip' },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered()
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol',
        maxwidth = 50,
      })
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] =  cmp.mapping.confirm({
          select = true,
          behavior = 'replace',
        }),
    }),
  })

  -- TODO investigate
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })
end

M.capabilities = function()
  return cmp_lsp.default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  );
end

return M
