lua <<EOF

local dap = require'dap'
dap.adapters.metals = {
  type = "server",
  name = "metals",
}

EOF
