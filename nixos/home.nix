{ pkgs, ... }:
let
  vimPlugingsGithub = {
    plenary-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "plenary.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "31807eef4ed574854b8a53ae40ea3292033a78ea";
        hash = "sha256-G84JTsj06vwidfEyaNIUvLLaKM9HB5zNAexCDWbGfu4=";
      };
    };
    nvim-cmp = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-cmp";
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-cmp";
        rev = "2427d06b6508489547cd30b6e86b1c75df363411";
        hash = "sha256-3YpEu/VlWO4yVf+tNqz0YbJZjOrbzWIxvUe3JliZepI=";
      };
    };
    # neo-tree-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    #   name = "neo-tree.nvim";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "nvim-neo-tree";
    #     repo = "neo-tree.nvim";
    #     rev = "v2.34";
    #     hash = "sha256-fXK6Mw0Xc17H13vtmKBBN9Bsy5ZFEc0qu29doNDMyfQ=";
    #   };
    # };
    navigator-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "navigator.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "numToStr";
        repo = "navigator.nvim";
        rev = "0c57f67a34eff7fd20785861926b7fe6bd76e2c2";
        hash = "sha256-THPIzyuECJTjoCq2k99KCLxYGunlf9BYM8FpKHiBLrg=";
      };
    };
    zk-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "zk-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "mickael-menu";
        repo = "zk-nvim";
        rev = "73affbc95fba3655704e4993a8929675bc9942a1";
        hash = "sha256-BQrF88hVSDc9zjCWcSSCnw1yhCfMu8zsMbilAI0Xh2c=";
      };
    };
    gitsigns-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "gitsigns.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "lewis6991";
        repo = "gitsigns.nvim";
        rev = "d7e0bcbe45bd9d5d106a7b2e11dc15917d272c7a";
        hash = "sha256-kyiQoboYq4iNLOj1iKA2cfXQ9FFiRYdvf55bX5Xvj8A=";
      };
    };
    tint-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "tint.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "levouh";
        repo = "tint.nvim";
        rev = "819a173c21175f2ef57fa0ad0b57ac4eb8c5425d";
        hash = "sha256-xqCrCMTemXpDTIrDU+UaNV8BzSUXn9j2VI5BRkjMLRg=";
      };
    };
    other-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "other.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "rgroli";
        repo = "other.nvim";
        rev = "9afecea37c9b5ffed65a21de9e585d548de7778a";
        hash = "sha256-df/L8ZOdjkviE6WRRe7uon82hlUb+yYDdtiN3pJ5OBs=";
      };
    };
  };
in
{

  # services.dunst.enable = true;
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # brightnessctl
    # gh
    # git
    # pavucontrol ## nix shelling into this fixed my sound
    # pinentry_qt
    # polybar
    # xclip
    # bitwarden
    # firefox
    # graalvm11-ce
    # rofi
    entr
    git-crypt
    gnupg
    jq
    kitty
    nerdfonts
    nodejs-14_x
    ripgrep
    sbt
    scala-cli
    zk
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };

  home.sessionVariables = {
    # workaround to allow kitty to run darwin-rebuild
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      ZVM_VI_ESCAPE_BINDKEY = "jk";
    };

    envExtra = builtins.readFile ./home/zsh/.zshenv;
    initExtra = builtins.readFile ./home/zsh/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  # Do I need this if the agent is enabled in configuration.nix?
  programs.gpg = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    # package = pkgs.neovim-nightly;

    extraPackages = with pkgs.unstable; [
      ltex-ls
      metals
      nodePackages.typescript-language-server
      rnix-lsp
      sumneko-lua-language-server
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = vimPlugingsGithub;
      in
      [
        pinned.gitsigns-nvim
        pinned.navigator-nvim
        pinned.nvim-cmp
        pinned.other-nvim
        pinned.plenary-nvim
        pinned.tint-nvim
        pinned.zk-nvim
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lua
        plug.cmp_luasnip
        plug.diaglist-nvim
        plug.fzf-lua
        plug.lsp-inlayhints-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.nui-nvim
        plug.nvim-autopairs
        plug.nvim-base16
        plug.nvim-dap
        plug.nvim-dap-virtual-text
        plug.nvim-lspconfig
        plug.nvim-metals
        plug.nvim-tree-lua
        plug.nvim-treesitter
        plug.nvim-ts-autotag
        plug.nvim-web-devicons
        plug.telescope-fzf-writer-nvim
        plug.telescope-nvim
        plug.telescope-symbols-nvim
        plug.vim-commentary
        plug.vim-fugitive
        plug.vim-nix
        plug.vim-pencil
        plug.vim-repeat
        plug.vim-rhubarb
        plug.vim-surround
        plug.zen-mode-nvim
      ];
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./home/git/.gitconfig;
  };

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./home/tmux/.tmux.conf;
  };

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  # programs.firefox.enable = true;

  # programs.gh.enable = true;

  programs.htop.enable = true;

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

  xdg.configFile.kitty = {
    source = ./home/kitty;
    recursive = true;
  };

  xdg.configFile.i3 = {
    source = ./home/i3;
    recursive = true;
  };

  xdg.configFile.polybar = {
    source = ./home/polybar;
    recursive = true;
  };

  xdg.configFile.rofi = {
    source = ./home/rofi;
    recursive = true;
  };

  home.file.".gitignore".source = ./home/git/.gitignore-global;

}
