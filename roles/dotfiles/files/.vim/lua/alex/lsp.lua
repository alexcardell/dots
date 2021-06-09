local comp   = require'completion'
local metals = require'metals'

local M = {}

M.metals = metals.bare_config

M.metals.on_attach = function(client, bufnr)
    comp.on_attach()
    metals.setup_dap()
  end

M.metals.init_options = {
     -- If you set this, make sure to have the `metals#status()` function
     -- in your statusline, or you won't see any status messages
     statusBarProvider            = "on";
     inputBoxProvider             = true;
     quickPickProvider            = true;
     executeClientCommandProvider = true;
     decorationProvider           = true;
     didFocusProvider             = true;
     debuggingProvider            = true;
   };

   M.handlers = {
     ["textDocument/hover"]          = metals['textDocument/hover'];
     ["metals/status"]               = metals['metals/status'];
     ["metals/inputBox"]             = metals['metals/inputBox'];
     ["metals/quickPick"]            = metals['metals/quickPick'];
     ["metals/executeClientCommand"] = metals["metals/executeClientCommand"];
     ["metals/publishDecorations"]   = metals["metals/publishDecorations"];
     ["metals/didFocusTextDocument"] = metals["metals/didFocusTextDocument"];
   };

M.metals.settings = {
     showImplicitArguments = true;
     showInferredType = true;
     superMethodLensesEnabled = true;
   };

M.lightbulb = {
    sign = {
        enabled = false,
        -- Priority of the gutter sign
        priority = 10,
    },
    float = {
        enabled = true,
        -- Text to show in the popup float
        text = "",
        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = { },
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "",
    }
}

return M
