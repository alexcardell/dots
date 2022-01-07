{ pkgs, config, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    ammonite
    autojump
    aws-vault
    awscli2
    bat
    bitwarden-cli
    coreutils-full
    coursier
    curl
    dasht
    element-desktop
    fd
    fzf
    gh
    git
    git-crypt
    gnupg
    jdk
    jq
    # unstable.kitty
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

