{ pkgs, ... }:
let 
  neo-tree-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neo-tree.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "a1f5f4b15cec517d632e7335d20400cb3f410606";
      hash = "sha256-Mxg+TNEwBMcEYVUiNxCjuiPtNnG+MSrcfn29YvXwboo";
    };
  };
  nvim-snippy = pkgs.vimUtils.buildVimPluginFrom2Nix  {
    name = "nvim-snippy";
    src = pkgs.fetchFromGitHub {
      owner = "dcampos";
      repo = "nvim-snippy";
      rev = "11ed49b8cf527aee154fb583409b90fa270fc7f8";
      hash = "sha256-XKlS2J0bqoaknrhICTynyTL9FDhW/UdHpYD/j5pE1UM=";
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
in {

  services.dunst.enable = true;

  home.packages = with pkgs; [
    bitwarden
    git
    git-crypt
    gnupg
    kitty
    nerdfonts
    pinentry_qt
    ripgrep
    xclip
  ];

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

    initExtra = builtins.readFile ./home/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
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
      rnix-lsp
      metals
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins = with pkgs.unstable.vimPlugins; [
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-snippy
      nvim-snippy
      neo-tree-nvim
      nui-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-metals
      plenary-nvim
      vim-nix
      vim-repeat
      vim-surround
      telescope-nvim
      telescope-fzf-writer-nvim
      telescope-symbols-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

  xdg.configFile."kitty/kitty.conf".source = ./home/kitty.conf;

  programs.firefox.enable = true;

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./home/.tmux.conf;
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./home/.gitconfig;
  };

  home.file.".gitignore".source = ./home/.gitignore-global;
}
