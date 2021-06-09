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

return M
