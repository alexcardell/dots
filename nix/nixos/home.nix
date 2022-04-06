{ pkgs, ... }:
{

  services.dunst.enable = true;

  home.packages = with pkgs; [
    bitwarden
    # firefox
    # fzf
    git
    git-crypt
    gnupg
    kitty
    pinentry_qt
    ripgrep
    # tmux
    xclip
  ];

  programs.zsh = {
    enable = true;
    # shellAliases = {
    #   ll = "ls -alh";
    #   ".." = "cd ..";
    # };

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
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins = with pkgs.unstable.vimPlugins; [
      cmp-nvim-lsp
      cmp-nvim-lua
      nvim-cmp
      nvim-lspconfig
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
}
