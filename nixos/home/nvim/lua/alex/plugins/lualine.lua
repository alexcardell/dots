local M = {}

M.setup = function()

  local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
    grey2   = '#969896',
  }

  local bubbles_theme = {
    normal = {
      a = { fg = colors.grey, bg = colors.white },
      b = { fg = colors.white, bg = colors.grey },
      c = { fg = colors.grey2, bg = colors.black },
      x = { fg = colors.grey2, bg = colors.black },
    },

    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    command = { a = { fg = colors.black, bg = colors.violet } },

    inactive = {
      a = { fg = colors.white, bg = colors.black },
      b = { fg = colors.white, bg = colors.black },
      c = { fg = colors.black, bg = colors.black },
    },
  }

  local gitsigns_diff_source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed
      }
    end
  end

  require('lsp-progress').setup()

  local lsp_status = function()
    return require('lsp-progress').progress() or ""
  end

  require('lualine').setup({
    options = {
      theme = bubbles_theme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        winbar = { 'Outline', 'NvimTree', 'qf', 'Avante', 'AvanteInput' },
        statusline = {},
      },
      globalstatus = true
    },
    sections = {
      lualine_a = {
        { 'mode', right_padding = 2 },
      },
      lualine_b = {
        'branch',
        { 'diff', source = gitsigns_diff_source }
      },
      lualine_c = { 'filename' },
      lualine_x = { lsp_status },
      lualine_y = { 'searchcount', 'filetype', 'progress', 'location', 'diagnostics' },
      lualine_z = {
        -- { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
  })
end

return M
