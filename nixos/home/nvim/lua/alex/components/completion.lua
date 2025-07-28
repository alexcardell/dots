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

M.capabilities = require('blink.cmp').get_lsp_capabilities()

M.setup = M.setup_blink

return M
