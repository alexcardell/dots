{ pkgs, ... }:
{
  imports = [
    ./nvim.nix
  ];

  manual.html.enable = false;
  manual.manpages.enable = false;
  manual.json.enable = false;

  # services.dunst.enable = true;
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    actionlint
    entr
    git-crypt
    git-extras
    git-filter-repo
    gnupg
    jq
    kitty
    nerdfonts
    nodejs-18_x
    ripgrep
    sbt
    shellcheck
    unixtools.watch
    unstable.jira-cli-go
    unstable.languagetool-rust
    unstable.ollama
    unstable.scala-cli
    unstable.sloth
    vale
    xdg-ninja
    yamllint
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

    envExtra = builtins.readFile ./zsh/.zshenv;
    initExtra = builtins.readFile ./zsh/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  home.file.".zsh" = {
    source = ./zsh/.zsh;
    recursive = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  # Do I need this if the agent is enabled in configuration.nix?
  programs.gpg = {
    enable = true;
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./git/.gitconfig;
  };

  home.file.".gitconfig.work".source = ./git/.gitconfig.work;

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./tmux/.tmux.conf;
  };

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  # programs.firefox.enable = true;

  # programs.gh.enable = true;

  programs.htop.enable = true;

  xdg.configFile.kitty = {
    source = ./kitty;
    recursive = true;
  };

  xdg.configFile.i3 = {
    source = ./i3;
    recursive = true;
  };

  xdg.configFile.polybar = {
    source = ./polybar;
    recursive = true;
  };

  xdg.configFile.rofi = {
    source = ./rofi;
    recursive = true;
  };

  home.file.".gitignore".source = ./git/.gitignore-global;

}
