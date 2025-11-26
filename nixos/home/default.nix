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
    bitwarden-cli
    bitwarden-desktop
    compose2nix
    coursier
    entr
    fd
    gh
    git-crypt
    git-filter-repo
    gnupg
    jq
    kitty
    nerd-fonts.sauce-code-pro
    nodejs_22
    nur.repos.forkprince.waterfox-bin
    ripgrep
    sbt
    shellcheck
    tenv
    unixtools.watch
    unstable.jira-cli-go
    unstable.languagetool-rust
    unstable.ollama
    unstable.scala-cli
    unstable.sloth
    unstable.spr
    unstable.vectorcode
    vale
    xdg-ninja
    yamllint
    zk
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk;
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
    initContent = builtins.readFile ./zsh/.zshrc;

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

    extraConfig =
      let
        isDarwin = pkgs.stdenv.isDarwin;
        commonConfig = builtins.readFile ./tmux/.tmux.conf;
        darwinConfig = builtins.readFile ./tmux/.tmux.darwin.conf;
      in
      if isDarwin then darwinConfig + "\n" + commonConfig else commonConfig;
  };

  xdg.configFile.tmux-scripts = {
    source = ./tmux/scripts;
    recursive = true;
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
