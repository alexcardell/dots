local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local cmp_git = require('cmp_git')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local compare = cmp.config.compare

local M = {}

M.setup = function()
  cmp.setup({
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
      },
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
        mode = 'symbol_text',
        maxwidth = 50,
      })
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({
        select = true,
        behavior = 'replace',
      }),
    }),
    preselect = cmp.PreselectMode.None,
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.score,
        compare.sort_text,
        compare.recently_used,
        compare.kind,
        compare.length,
        compare.order,
      },
    },
    completion = {
      completeopt = 'menu,menuone'
    },
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
