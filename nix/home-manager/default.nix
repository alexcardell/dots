{ pkgs, config, ... }:

{
  home.stateVersion = "21.11";

  home.packages = with pkgs; [
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
    # fzf
    gh
    git
    git-crypt
    gnupg
    jq
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
    nodejs-14_x
    nodePackages.typescript-language-server
    yarn
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
    # (pkgs.jdk8.overrideAttrs (_: { postPatch = "rm man; ln -s ../zulu-8.jdk/Contents/Home/man man"; }));
  };

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

    envExtra = builtins.readFile ./home/zsh/.zshenv;
    initExtra = builtins.readFile ./home/zsh/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
