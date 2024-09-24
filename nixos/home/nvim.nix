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
    avante-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "avante.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "yetone";
        repo = "avante.nvim";
        rev = "fc1bcda8220cb4b81648db86670e5428c7d477b0";
        hash = "sha256-1i1M/sK4SfSWsGhmbVpgT5vgKVSryYi+rw41u5WTNU4=";
      };
    };
    codecompanion-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "codecompanion.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "olimorris";
        repo = "codecompanion.nvim";
        rev = "abb1b8c6535e2a792b757ae7fb9253192735f5a8";
        hash = "sha256-uaApGE6dl1G605QTBedGQijvQ4uHitXGKZ0EOu6zvCo=";
      };
    };
    render-markdown-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "render-markdown.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "MeanderingProgrammer";
        repo = "render-markdown.nvim";
        rev = "bc8213ddcd91d2045cc3813df861adb93fbf2d2d";
        hash = "sha256-kWENpKZZhqUFYsJkJFts6J0Wc9hhRPV0G8X0TJY9GlU=";
      };
    };
    lsp-progress-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "lsp-progress.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "linrongbin16";
        repo = "lsp-progress.nvim";
        rev = "d5f4d28efe75ce636bfbe271eb45f39689765aab";
        hash = "sha256-OafRT5AnxRTOh7MYofRFjti0+pobKQihymZs/kr5w0A=";
      };
    };
    quicker-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "quicker.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "stevearc";
        repo = "quicker.nvim";
        rev = "183041a46d6c908eefb1c23ea02cce9c8f41256e";
        hash = "sha256-vhDXkE33NkiCs8PUB2PIzljaL15V3Ac62FRgnEZs06M=";
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
      in [
        # plug.cmp-nvim-lsp-signature-help
        # plug.cmp-path
        # plug.markdown-preview-nvim
        # plug.marks-nvim
        # plug.nvim-lint
        # plug.telescope-fzf-writer-nvim
        # plug.telescope-symbols-nvim
        # plug.twilight-nvim
        # plug.vim-commentary
        # plug.vim-fugitive
        # plug.vim-illuminate
        # plug.vim-nix
        # plug.vim-repeat
        # plug.vim-rhubarb
        # plug.vim-surround
        # plug.vim-wakatime
        # plug.zen-mode-nvim
        # plug.zk-nvim
        pinned.avante-nvim
        pinned.codecompanion-nvim
        pinned.lsp-progress-nvim
        pinned.nvim-metals
        pinned.quicker-nvim
        pinned.render-markdown-nvim
        plug.Navigator-nvim
        plug.base16-nvim
        plug.cmp-buffer
        plug.cmp-dap
        plug.cmp-git
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lua
        plug.cmp_luasnip
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fidget-nvim
        plug.gitsigns-nvim
        plug.hardtime-nvim
        plug.indent-blankline-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.neogit
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-cmp
        plug.nvim-dap
        plug.nvim-dap-ui
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-nio
        plug.nvim-surround
        plug.nvim-treesitter-textobjects # TODO add more textobjects
        plug.nvim-treesitter.withAllGrammars
        plug.nvim-ts-autotag
        plug.nvim-web-devicons
        plug.oil-nvim
        plug.other-nvim
        plug.outline-nvim
        plug.plenary-nvim
        plug.telescope-dap-nvim
        plug.telescope-nvim
        plug.telescope-ui-select-nvim
        plug.tint-nvim
        plug.undotree
        plug.vim-dadbod
        plug.vim-dadbod-completion
        plug.vim-dadbod-ui
        plug.vim-fugitive
        plug.vim-pencil
        plug.vim-rhubarb
      ];
  };
}
