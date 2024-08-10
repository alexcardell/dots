{ pkgs, ... }:
let
  vimPluginsGithub = {
    nvim-metals = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-metals";
      src = pkgs.fetchFromGitHub {
        owner = "scalameta";
        repo = "nvim-metals";
        rev = "1b87e6bfa4174b5fbaee9ca7ec79d8eae8df7f18";
        hash = "sha256-VQOolBCVYZ1T71REjgD7X/+txd1awmdGgW154hc30Y8=";
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
    gen-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "gen.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "David-Kunz";
        repo = "gen.nvim";
        rev = "c9a73d8c0d462333da6d2191806ff98f2884d706";
        hash = "sha256-Yp7HrDMOyR929AfM7IjEz4dP3RhIx9kXZ1Z3zRr5yJg=";
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
        # pinned.ogpt-nvim
        # plug.cmp-buffer
        # plug.cmp-git
        # plug.cmp-nvim-lsp-signature-help
        # plug.cmp-nvim-lua
        # plug.cmp-path
        # plug.copilot-cmp
        # plug.copilot-lua
        # plug.diaglist-nvim
        # plug.fzf-lua
        # plug.indent-blankline-nvim
        # plug.lsp-inlayhints-nvim
        # plug.lspkind-nvim
        # plug.lualine-nvim
        # plug.markdown-preview-nvim
        # plug.marks-nvim
        # plug.none-ls-nvim
        # plug.nui-nvim
        # plug.nvim-autopairs
        # plug.nvim-dap
        # plug.nvim-dap-virtual-text
        # plug.nvim-lint
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
        pinned.gen-nvim
        pinned.nvim-metals
        plug.Navigator-nvim
        plug.cmp-nvim-lsp
        plug.cmp_luasnip
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fidget-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
        plug.luasnip
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-cmp
        plug.nvim-lspconfig
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
