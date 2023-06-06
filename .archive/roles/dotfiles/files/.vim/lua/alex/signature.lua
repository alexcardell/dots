--------------------------
-- lspsignature config --
--------------------------

local M = {}

M.config = function()
return {
  bind = true,
  floating_window = true,
  hint_enable = true,
  extra_trigger_chars = {"(", ","},
  handler_opts = {
    border = 'single'
  }
}

end

return M
