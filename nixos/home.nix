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
in {

  services.dunst.enable = true;

  home.packages = with pkgs; [
    bitwarden
    # firefox
    git
    git-crypt
    gnupg
    kitty
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
      neo-tree-nvim
      nui-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-metals
      plenary-nvim
      vim-nix
      vim-repeat
      vim-surround
    ];
  };

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

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
