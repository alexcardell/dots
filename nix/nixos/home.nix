 { pkgs, ... }: 
 {
    home.packages = with pkgs; [ 
      bitwarden
      firefox
      fzf
      git
      git-crypt
      gnupg
      kitty
      neovim
      tmux
      pinentry_qt
    ];

    # I don't think this does anything
    programs.zsh.enable = true;

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
}
