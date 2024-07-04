{ pkgs, ... }:
let
  vimPluginsGithub = {
    nvim-metals = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-metals";
      src = pkgs.fetchFromGitHub {
        owner = "scalameta";
        repo = "nvim-metals";
        rev = "c6268555d0b471262af78818f11a086ddf30688b";
        hash = "sha256-r5s0eNMSxBnmu1LYs/+RrhNk356ikfCPA1FfiJcX+K8=";
      };
    };
    base16-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "base16-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "RRethy";
        repo = "base16-nvim";
        rev = "3c6a56016cea7b892f1d5b9b5b4388c0f71985be";
        hash = "sha256-l94LjAM2viB0jQv5FUlSmr4RF/9kd5qZUdov75U+x00=";
      };
    };
    # nvim-dbee = pkgs.vimUtils.buildVimPluginFrom2Nix {
    #   name = "nvim-dbee";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "kndndrj";
    #     repo = "nvim-dbee";
    #     rev = "77c72f6789bea19c9076e7006078ab07f763999c";
    #     hash = "sha256-LZgfBFA5zQIfFjS1r5IBOu3CG5I4uFKvWx2Ar7hVtLQ=";
    #   };
    # };
    oatmeal-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "oatmeal.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "dustinblackman";
        repo = "oatmeal.nvim";
        rev = "74c1df535b397a0c29d904adc2a3c962198c7ab6";
        hash = "sha256-kdB936CYYmBPynvZTGbEOCH0k30QTuGyqEbKB+nAWfY=";
      };
    };
    # fork of symbols-outline-nvim
    outline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "outline.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "hedyhli";
        repo = "outline.nvim";
        rev = "78ad5cb583c0ec0ea56c89e622bc16e45aaca934";
        hash = "sha256-zskXfrbEryKyjHfbACvCkiAoVAk94uWa2KRDZlTSejQ=";
      };
    };
  };
in
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
      ltex-ls
      lua-language-server
      metals
      nixd
      nodePackages.typescript-language-server
      terraform-ls
      wakatime
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = vimPluginsGithub;
        treesitter = (plug.nvim-treesitter.withPlugins (plugins: with plugins; [
          # scala 
          c
          hcl
          lua
          smithy
          terraform
        ]));
      in
      [
        # plug.copilot-cmp
        # plug.symbols-outline-nvim
        pinned.nvim-metals
        pinned.oatmeal-nvim
        pinned.outline-nvim
        pinned.base16-nvim
        plug.Navigator-nvim
        plug.cmp-buffer
        plug.cmp-git
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lsp-signature-help
        plug.cmp-nvim-lua
        plug.cmp-path
        plug.cmp_luasnip
        plug.copilot-lua
        plug.diaglist-nvim
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fzf-lua
        plug.gitsigns-nvim
        plug.indent-blankline-nvim
        plug.lsp-inlayhints-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.markdown-preview-nvim
        plug.marks-nvim
        plug.none-ls-nvim
        plug.nui-nvim
        plug.nvim-autopairs
        # plug.base16-nvim
        plug.nvim-cmp
        plug.nvim-dap
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-navic
        plug.nvim-tree-lua
        plug.nvim-web-devicons
        plug.other-nvim
        plug.plenary-nvim
        plug.telescope-fzf-writer-nvim
        plug.telescope-nvim
        plug.telescope-symbols-nvim
        plug.tint-nvim
        plug.twilight-nvim
        plug.vim-commentary
        plug.vim-dadbod
        plug.vim-dadbod-completion
        plug.vim-dadbod-ui
        plug.vim-fugitive
        plug.vim-illuminate
        plug.vim-nix
        plug.vim-pencil
        plug.vim-repeat
        plug.vim-rhubarb
        plug.vim-surround
        plug.vim-wakatime
        plug.zen-mode-nvim
        plug.zk-nvim
        treesitter
      ];
  };
}
