{ pkgs, ... }:
let
  vimPluginsGithub = {
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
        # plug.symbols-outline-nvim
        pinned.oatmeal-nvim
        pinned.outline-nvim
        plug.Navigator-nvim
        plug.cmp-buffer
        plug.cmp-git
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lsp-signature-help
        plug.cmp-nvim-lua
        plug.cmp-path
        plug.cmp_luasnip
        # plug.copilot-cmp
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
        plug.none-ls-nvim
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-base16
        plug.nvim-cmp
        plug.nvim-dap
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-metals
        plug.nvim-navic
        plug.nvim-tree-lua
        plug.nvim-web-devicons
        plug.other-nvim
        plug.plenary-nvim
        plug.telescope-fzf-writer-nvim
        plug.telescope-nvim
        plug.telescope-symbols-nvim
        plug.tint-nvim
        plug.todo-comments-nvim
        plug.vim-commentary
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
