{ pkgs, ... }:
let
  plenary-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "plenary.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "31807eef4ed574854b8a53ae40ea3292033a78ea";
      hash = "sha256-G84JTsj06vwidfEyaNIUvLLaKM9HB5zNAexCDWbGfu4=";
    };
  };
  neo-tree-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neo-tree.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "v2.34";
      hash = "sha256-fXK6Mw0Xc17H13vtmKBBN9Bsy5ZFEc0qu29doNDMyfQ=";
    };
  };
  nvim-snippy = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-snippy";
    src = pkgs.fetchFromGitHub {
      owner = "dcampos";
      repo = "nvim-snippy";
      rev = "1860215584d4835d87f75896f07007b3b3c06df4";
      hash = "sha256-Qprdlfd88nZKbVRqHRNFZfhiDgNnWcqR4MYIE5b79hw=";
    };
  };
  cmp-snippy = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "cmp-snippy";
    src = pkgs.fetchFromGitHub {
      owner = "dcampos";
      repo = "cmp-snippy";
      rev = "9af1635fe40385ffa3dabf322039cb5ae1fd7d35";
      hash = "sha256-vseoNZtB8jPGAJD8zFJigwKn11rXsNy04ipg0fYM46k=";
    };
  };
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
in
{

  # services.dunst.enable = true;

  home.packages = with pkgs; [
    # bitwarden
    # brightnessctl
    # firefox
    # pinentry_qt
    # polybar
    # rofi
    # xclip
    aws-vault
    gh
    git
    git-crypt
    gnupg
    graalvm11-ce
    jq
    kitty
    nerdfonts
    nodejs-14_x
    ripgrep
    sbt
    zk
  ];

  home.sessionVariables = {
    # workaround to allow kitty to run darwin-rebuild
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
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
  programs.gpg.enable = true;

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs; [
      metals
      rnix-lsp
      # sumneko-lua-language-server
      nodePackages.typescript-language-server
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
      in
      [
        # cmp-snippy
        gitsigns-nvim
        navigator-nvim
        neo-tree-nvim
        nvim-snippy
        plenary-nvim
        plug.cmp_luasnip
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lua
        plug.diaglist-nvim
        plug.fzf-lua
        plug.lualine-nvim
        plug.luasnip
        plug.nui-nvim
        plug.nvim-base16
        plug.nvim-cmp
        plug.nvim-lspconfig
        plug.nvim-metals
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
        zk-nvim
      ];
  };

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

  xdg.configFile.kitty = {
    source = ./home/kitty;
    recursive = true;
  };

  # xdg.configFile.i3 = {
  #   source = ./home/i3;
  #   recursive = true;
  # };

  xdg.configFile.polybar = {
    source = ./home/polybar;
    recursive = true;
  };

  # xdg.configFile.rofi = {
  #   source = ./home/rofi;
  #   recursive = true;
  # };

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./home/tmux/.tmux.conf;
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./home/git/.gitconfig;
  };

  home.file.".gitignore".source = ./home/git/.gitignore-global;

}
