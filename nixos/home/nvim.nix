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
      ltex-ls
      lua-language-server
      # TODO use unstable when 1.6.7 is on nixpkgs
      pkgs.metals
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
            version = "cfa49d9dc";
            nvimRequireCheck = [ "agentic" ];
            src = pkgs.unstable.fetchFromGitHub {
              owner = "carlos-algms";
              repo = "agentic.nvim";
              rev = "cfa49d9dc3d9712ed10a963706caa55cc0eb62aa";
              hash = "sha256-QWb0kctWiwfhDKv3hUdhpmJwkS9nO9OQ8/NUmRBXgvA=";
            };
          };
          auto-dark-mode-nvim = pkgs.unstable.vimUtils.buildVimPlugin {
            pname = "auto-dark-mode.nvim";
            version = "e300259ec";
            src = pkgs.unstable.fetchFromGitHub {
              owner = "f-person";
              repo = "auto-dark-mode.nvim";
              rev = "e300259ec777a40b4b9e3c8e6ade203e78d15881";
              hash = "sha256-PhhOlq4byctWJ5rLe3cifImH56vR2+k3BZGDZdQvjng=";
            };
          };
        };
      in
      [
        plug.Navigator-nvim
        pinned.agentic-nvim
        pinned.auto-dark-mode-nvim
        plug.avante-nvim
        plug.base16-nvim
        plug.blink-cmp
        plug.codecompanion-history-nvim
        plug.codecompanion-nvim
        plug.codecompanion-spinner-nvim
        # plug.copilot-vim
        plug.diffview-nvim
        plug.edgy-nvim
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
        plug.nvim-metals
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
        plug.vectorcode-nvim
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
