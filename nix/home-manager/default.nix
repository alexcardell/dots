{ pkgs, config, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # jdk11
    # unstable.kitty
    # zk
    # openjdk8
    # jdk8
    # (jdk8.overrideAttrs (_: { postPatch = "rm man; ln -s ../zulu-8.jdk/Contents/Home/man man"; }))
    ammonite
    autojump
    aws-vault
    awscli2
    bat
    bitwarden-cli
    cmake
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

  programs.java.enable = true;
  programs.java.package = (pkgs.jdk8.overrideAttrs (_: { postPatch = "rm man; ln -s ../zulu-8.jdk/Contents/Home/man man"; }));
}
