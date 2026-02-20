local M = {}

M.setup = function()
  local function focus_first_oil_entry(bufnr)
    local winid = vim.fn.bufwinid(bufnr)
    if winid == -1 then
      return
    end

    if vim.api.nvim_buf_line_count(bufnr) < 2 then
      return
    end

    local cursor = vim.api.nvim_win_get_cursor(winid)
    if cursor[1] ~= 1 then
      return
    end

    local ok, first_entry = pcall(require("oil").get_entry_on_line, bufnr, 1)
    if ok and first_entry and (first_entry.id == 0 or first_entry.name == "..") then
      vim.api.nvim_win_set_cursor(winid, { 2, 0 })
    end
  end

  vim.api.nvim_create_autocmd("User", {
    desc = "Start on first entry when oil enters a directory",
    group = vim.api.nvim_create_augroup("oil-initial-cursor", { clear = true }),
    pattern = "OilEnter",
    callback = function(args)
      local bufnr = args.data and args.data.buf or args.buf
      vim.schedule(function()
        focus_first_oil_entry(bufnr)
      end)
    end,
  })

  -- Declare a global function to retrieve the current directory
  function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
      return vim.fn.fnamemodify(dir, ":~")
    else
      -- If there is no current directory (e.g. over ssh), just show the buffer name
      return vim.api.nvim_buf_get_name(0)
    end
  end

  require("oil").setup({
    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
    view_options = {
      show_hidden = true
    }
  })
end

return M
