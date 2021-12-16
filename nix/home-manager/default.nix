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
    gnupg
    jdk11
    jq
    metals
    neovim
    nix
    nixfmt
    openssh
    python39Full
    ranger
    ripgrep
    rnix-lsp
    tmux
    sbt
    sumneko-lua-language-server
  ];
}

