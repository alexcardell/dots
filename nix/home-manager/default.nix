{ pkgs, config, ... }:

{
  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    # jdk11
    # unstable.kitty
    # zk
    # openjdk8
    # jdk8
    # (jdk8.overrideAttrs (_: { postPatch = "rm man; ln -s ../zulu-8.jdk/Contents/Home/man man"; }))
    # dasht
    # element-desktop
    # ranger
    # sumneko-lua-language-server
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
    fd
    fzf
    gh
    git
    git-crypt
    gnupg
    jq
    kitty
    metals
    nerdfonts
    nix
    nixfmt
    openssh
    python39Full
    ripgrep
    rnix-lsp
    sbt
    tmux
    unstable.neovim
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
    # (pkgs.jdk8.overrideAttrs (_: { postPatch = "rm man; ln -s ../zulu-8.jdk/Contents/Home/man man"; }));
  };
}
