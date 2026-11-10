{ pkgs, ... }:
{
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs.unstable; [
      docker-compose-language-service
      dockerfile-language-server
      jdt-language-server
      kotlin-language-server
      ltex-ls-plus
      lua-language-server
      metals
      nixd
      postgres-language-server
      rust-analyzer
      terraform-ls
      typescript-language-server
      yaml-language-server
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = {
          agentic-nvim = pkgs.unstable.vimUtils.buildVimPlugin {
            pname = "agentic.nvim";
            version = "4750d6ce4";
            nvimRequireCheck = [ "agentic" ];
            src = pkgs.unstable.fetchFromGitHub {
              owner = "carlos-algms";
              repo = "agentic.nvim";
              rev = "4750d6ce4298b3018dd67f975a1457afbeeaa09f";
              hash = "sha256-LfjVF0Elq0VQLxO3LQZKjt6IdsK2JvUlW8mw1EeA+Hk=";
            };
          };
          auto-dark-mode-nvim = pkgs.unstable.vimUtils.buildVimPlugin {
            pname = "auto-dark-mode.nvim";
            version = "2b16a24c2";
            src = pkgs.unstable.fetchFromGitHub {
              owner = "f-person";
              repo = "auto-dark-mode.nvim";
              rev = "2b16a24c202892e61fca7df4d2d7c4c872a44165";
              hash = "sha256-xBpdk0D2LauLJoktw/vQfvic07NsKaBDeL8KAl4KE7s=";
            };
          };
          nvim-metals = pkgs.unstable.vimUtils.buildVimPlugin {
            pname = "nvim-metals";
            version = "a4b20656b";
            src = pkgs.unstable.fetchFromGitHub {
              owner = "scalameta";
              repo = "nvim-metals";
              rev = "a4b20656bf1014404dd63bf9fd5f22fcc50fee52";
              hash = "sha256-3Vqc82HfKRKw/4LrrpamInCY5uVT6dfuENhmMie0DQ8=";
            };
          };
        };
      in
      [
        plug.Navigator-nvim
        pinned.agentic-nvim
        pinned.auto-dark-mode-nvim
        pinned.nvim-metals
        plug.base16-nvim
        plug.blink-cmp
        plug.diffview-nvim
        plug.fidget-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
        plug.img-clip-nvim
        plug.indent-blankline-nvim
        plug.lsp-progress-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.marks-nvim
        plug.neogit
        plug.neoscroll-nvim
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-dap
        plug.nvim-dap-ui
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-jdtls
        plug.nvim-nio
        plug.nvim-surround
        plug.nvim-treesitter-textobjects # TODO add more textobjects
        plug.nvim-treesitter.withAllGrammars
        plug.treesitter-modules-nvim
        plug.nvim-ts-autotag
        plug.nvim-web-devicons
        plug.oil-nvim
        plug.other-nvim
        plug.outline-nvim
        plug.plenary-nvim
        plug.render-markdown-nvim
        plug.telescope-dap-nvim
        plug.telescope-nvim
        plug.telescope-ui-select-nvim
        plug.tint-nvim
        plug.undotree
        plug.vim-dadbod
        plug.vim-dadbod-completion
        plug.vim-dadbod-ui
        plug.vim-flog
        plug.vim-fugitive
        plug.vim-pencil
        plug.vim-rhubarb
      ];
  };
}
