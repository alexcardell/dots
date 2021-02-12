local comp   = require'completion'

local metals = require'metals'

M = metals.bare_config

M.on_attach = function()
    comp.on_attach()
    -- setup.auto_commands()
  end

M.init_options = {
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

M.settings = {
     showImplicitArguments = true;
     showInferredType = true;
     superMethodLensesEnabled = true;
   };

return M
