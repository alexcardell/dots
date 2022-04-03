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
      pinentry_qt
      ripgrep
      tmux
      xclip
    ];

    programs.zsh = {
      enable = true;
      # shellAliases = {
      #   ll = "ls -alh";
      #   ".." = "cd ..";
      # };

      sessionVariables = {
        EDITOR="nvim";
	ZVM_VI_ESCAPE_BINDKEY="jk";
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

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };

    services.dunst.enable = true;
}
