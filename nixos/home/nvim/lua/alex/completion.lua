local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local cmp_git = require('cmp_git')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local M = {}

M.setup = function()
  cmp.setup({
    sources = cmp.config.sources(
    -- group 1
      {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
      -- group 2
      {
        { name = 'buffer' },
      }
    ),
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
      ['<Tab>'] = cmp.mapping.confirm({
        select = true,
        behavior = 'replace',
      }),
    }),
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })

  -- TODO investigate
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })

  cmp_git.setup()
end

M.capabilities =
    cmp_lsp.default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    );

return M
