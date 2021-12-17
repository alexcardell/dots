{ pkgs, config, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    ammonite
    autojump
    awscli2
    bat
    bitwarden-cli
    coreutils-full
    curl
    element-desktop
    fd
    fzf
    gh
    git
    git-crypt
    gnupg
    jdk11
    jq
    metals
    neovim
    nerdfonts
    nix
    nixfmt
    openssh
    python39Full
    ranger
    ripgrep
    rnix-lsp
    sbt
    sumneko-lua-language-server
    tmux
  ];
}

