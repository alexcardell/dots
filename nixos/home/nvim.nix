{ pkgs, ... }:
let
  vimPluginsGithub = {
    nvim-metals = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-metals";
      src = pkgs.fetchFromGitHub {
        owner = "scalameta";
        repo = "nvim-metals";
        rev = "1b87e6bfa4174b5fbaee9ca7ec79d8eae8df7f18";
        hash = "sha256-0000000000000000000000000000000000000000000=";
      };
    };
    ogpt-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "ogpt.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "huynle";
        repo = "ogpt.nvim";
        rev = "aad5dfbbbc6e90e12cb15b77d0dc15da83077b48";
        hash = "sha256-l7lFP2hgvK1IBv27pIfvXo68/cXbq8jxtYz/9NUj9Zs=";
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
      # wakatime
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = vimPluginsGithub;
        treesitter = plug.nvim-treesitter.withAllGrammars;
        # treesitter = (plug.nvim-treesitter.withPlugins (plugins: with plugins; [ ])
      in
      [
        # plug.cmp-buffer
        # plug.cmp-git
        # plug.cmp-nvim-lsp
        # plug.cmp-nvim-lsp-signature-help
        # plug.cmp-nvim-lua
        # plug.cmp-path
        # plug.cmp_luasnip
        # plug.copilot-cmp
        # plug.copilot-lua
        # plug.diaglist-nvim
        # plug.diffview-nvim
        # plug.fzf-lua
        # plug.indent-blankline-nvim
        # plug.lsp-inlayhints-nvim
        # plug.lspkind-nvim
        # plug.lualine-nvim
        # plug.luasnip
        # plug.markdown-preview-nvim
        # plug.marks-nvim
        # plug.none-ls-nvim
        # plug.nui-nvim
        # plug.nvim-autopairs
        # plug.nvim-cmp
        # plug.nvim-dap
        # plug.nvim-dap-virtual-text
        # plug.nvim-lint
        # plug.nvim-lspconfig
        # plug.nvim-navic
        # plug.nvim-tree-lua
        # plug.nvim-web-devicons
        # plug.other-nvim
        # plug.symbols-outline-nvim
        # plug.telescope-fzf-writer-nvim
        # plug.telescope-symbols-nvim
        # plug.tint-nvim
        # plug.twilight-nvim
        # plug.vim-commentary
        # plug.vim-dadbod
        # plug.vim-dadbod-completion
        # plug.vim-dadbod-ui
        # plug.vim-fugitive
        # plug.vim-illuminate
        # plug.vim-nix
        # plug.vim-pencil
        # plug.vim-repeat
        # plug.vim-rhubarb
        # plug.vim-surround
        # plug.vim-wakatime
        # plug.zen-mode-nvim
        # plug.zk-nvim
        pinned.ogpt-nvim
        plug.Navigator-nvim
        plug.edgy-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-treesitter-textobjects # TODO add more textobjects
        plug.nvim-ts-autotag
        plug.oil-nvim
        plug.plenary-nvim
        plug.telescope-nvim
        plug.telescope-ui-select-nvim
        treesitter
      ];
  };
}
