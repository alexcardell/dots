local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local snippy = require('snippy')

local M = {}

M.setup = function()
  cmp.setup({
    sources = {
      { name = 'nvim_lsp' },
      -- { name = 'buffer' },
      { name = 'snippy' },
    },
    snippet = {
      expand = function(args)
        snippy.expand_snippet(args.body)
      end
    },
    documentation = {
      border = 'single'
    },
    -- formatting = {
    --   format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    -- },
    -- experminetal = {
    --   ghost_text = true,
    -- },
    mapping = {
      ['<Tab>'] = cmp.mapping.confirm({select = true}),
    }
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
