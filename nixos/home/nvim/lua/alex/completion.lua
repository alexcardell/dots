local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
-- local snippy = require('snippy')
local luasnip = require('luasnip')

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
    -- window = {
    --   completion = cmp.config.window.bordered(),
    --   documentation = cmp.config.window.bordered()
    -- },
    -- formatting = {
    --   format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    -- },
    -- experminetal = {
    --   ghost_text = true,
    -- },
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
  return cmp_lsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  );
end

return M
