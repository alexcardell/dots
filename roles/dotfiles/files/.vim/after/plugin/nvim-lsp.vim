let g:metals_server_version = '0.10.3'

lua <<EOF

local lsp    = require'lspconfig'
local comp   = require'completion'

lsp.dockerls.setup{on_attach=comp.on_attach}
lsp.hls.setup{on_attach=comp.on_attach}
lsp.jdtls.setup{on_attach=comp.on_attach}
lsp.tsserver.setup{on_attach=comp.on_attach}
lsp.vimls.setup{on_attach=comp.on_attach}

-- rescript
lsp.rescriptls.setup {
  on_attach = comp.on_attach;
  cmd = {
    "node",
    "/home/alex/.vim/plug/vim-rescript/server/out/server.js",
    "--stdio"
  };
  filetypes = {"rescript", "reason"};
}

-- Lua
lsp.sumneko_lua.setup {
  on_attach=comp.on_attach;
  cmd = {
    "/home/alex/Code/vendor/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    "/home/alex/Code/vendor/lua-language-server/main.lua"
  };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- since using mainly for neovim
        path = vim.split(package.path, ';')
      },
      diagnostics = {globals = {'vim', 'it'}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}

EOF

nnoremap <silent> <localleader>d   <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <localleader>t   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <localleader>h   <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>H   <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <localleader>l   <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <localleader>]               <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <localleader>[               <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <localleader>i   <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <localleader>r   <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <localleader>R   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <localleader>s   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <localleader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <localleader>c   <cmd>lua vim.lsp.buf.code_action()<CR>

" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
