local lint = require('lint')

lint.linters_by_ft = {
  markdown = {'vale'},
  sh = {'shellcheck',},
}

return lint
