{ pkgs, ... }:
let 
  telescope-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "telescope.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "92019d5053674676576b021904935d101b059fd5";
      hash = "sha256-Ss3Ts2LbZm2WisGiTg1pELoySeN49ARqxfEAaaw0lA8=";
    };
  };
  neo-tree-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neo-tree.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "44310cf6dd0e57b747f0946976d17e0106c9e611";
      hash = "sha256-PHCzXBSzAojasmcFFdxjQwTLfcnfA6qQV2SWar9+aEI=";
    };
  };
  nvim-snippy = pkgs.vimUtils.buildVimPluginFrom2Nix  {
    name = "nvim-snippy";
    src = pkgs.fetchFromGitHub {
      owner = "dcampos";
      repo = "nvim-snippy";
      rev = "11ed49b8cf527aee154fb583409b90fa270fc7f8";
      hash = "sha256-XKlS2J0bqoaknrhICTynyTL9FDhW/UdHpYD/j5pE1UM=";
    };
  };
  cmp-snippy = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "cmp-snippy";
    src = pkgs.fetchFromGitHub {
      owner = "dcampos";
      repo = "cmp-snippy";
      rev = "9af1635fe40385ffa3dabf322039cb5ae1fd7d35";
      hash = "sha256-vseoNZtB8jPGAJD8zFJigwKn11rXsNy04ipg0fYM46k=";
    };
  };
  navigator-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "navigator.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "numToStr";
      repo = "navigator.nvim";
      rev = "52225923679ec866651bb0c2e0691374131ec939";
      hash = "sha256-2xJEFvymWpnZpTqoQA6ViURFNoqcoqiAUGootZqO304=";
    };
  };
in {

  services.dunst.enable = true;

  home.packages = with pkgs; [
    bitwarden
    firefox
    git
    git-crypt
    gnupg
    kitty
    nerdfonts
    pinentry_qt
    ripgrep
    xclip
  ];

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

    initExtra = builtins.readFile ./home/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  # Do I need this if the agent is enabled in configuration.nix?
  programs.gpg.enable = true;

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs; [
      metals
      rnix-lsp
      sumneko-lua-language-server
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins = let 
      plug = pkgs.unstable.vimPlugins;
    in [
      cmp-snippy
      navigator-nvim
      neo-tree-nvim
      nvim-snippy
      plug.cmp-nvim-lsp
      plug.cmp-nvim-lua
      plug.lualine-nvim
      plug.nui-nvim
      plug.nvim-cmp
      plug.nvim-lspconfig
      plug.nvim-metals
      plug.nvim-web-devicons
      plug.plenary-nvim
      plug.telescope-fzf-writer-nvim
      plug.telescope-symbols-nvim
      plug.vim-nix
      plug.vim-repeat
      plug.vim-surround
      telescope-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

  xdg.configFile."kitty/kitty.conf".source = ./home/kitty.conf;

  # programs.firefox.enable = true;

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./home/.tmux.conf;
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./home/.gitconfig;
  };

  home.file.".gitignore".source = ./home/.gitignore-global;
}
