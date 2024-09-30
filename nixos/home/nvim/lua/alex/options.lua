-- indentation
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse
vim.opt.mouse = 'a'

-- don't show mode (it will be in statusline)
vim.opt.showmode = false

-- on enter, wrap next line equally to current line
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- disable swap
vim.opt.swapfile = false

-- autoread files
vim.opt.autoread = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- enable signcolumn
vim.opt.signcolumn = 'yes'

-- decrease update time / CursorHold time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Non conventional whitespace characters
-- TODO pick better characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Github Actions filetype
vim.filetype.add({
  pattern = {
    ['.*/.github/workflows/.*%.yml'] = 'yaml.ghaction',
    ['.*/.github/workflows/.*%.yaml'] = 'yaml.ghaction',
  },
})
