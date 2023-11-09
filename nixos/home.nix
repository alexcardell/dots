{ pkgs, ... }:
let
  vimPluginsGithub = {
    # other-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    #   name = "other.nvim";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "rgroli";
    #     repo = "other.nvim";
    #     rev = "9afecea37c9b5ffed65a21de9e585d548de7778a";
    #     hash = "sha256-df/L8ZOdjkviE6WRRe7uon82hlUb+yYDdtiN3pJ5OBs=";
    #   };
    # };
  };
in
{

  # services.dunst.enable = true;
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    entr
    git-crypt
    git-filter-repo
    gnupg
    jq
    kitty
    nerdfonts
    nodejs-18_x
    ripgrep
    sbt
    unixtools.watch
    unstable.languagetool-rust
    unstable.scala-cli
    unstable.sloth
    vale
    xdg-ninja
    zk
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
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

  home.file.".zsh" = {
    source = ./home/zsh/.zsh;
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

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    # package = pkgs.unstable.neovim;

    extraPackages = with pkgs.unstable; [
      ltex-ls
      lua-language-server
      metals
      nodePackages.typescript-language-server
      rnix-lsp
      terraform-ls
      wakatime
    ];

    # see xdg.configFile.nvim lua directory
    extraConfig = ''
      lua require('init__')
    '';

    plugins =
      let
        plug = pkgs.unstable.vimPlugins;
        pinned = vimPluginsGithub;
      in
      [
        (plug.nvim-treesitter.withPlugins (plugins: with plugins; [
          # scala 
          c
          hcl
          lua
          smithy
          terraform
        ]))
        # plug.cmp-nvim-lsp-document-symbol
        # plug.nvim-ts-autotag
        plug.Navigator-nvim
        plug.cmp-nvim-lsp
        plug.cmp-nvim-lsp-signature-help
        plug.cmp-nvim-lua
        plug.cmp_luasnip
        plug.diaglist-nvim
        plug.diffview-nvim
        plug.edgy-nvim
        plug.fzf-lua
        plug.gitsigns-nvim
        plug.lsp-inlayhints-nvim
        plug.lspkind-nvim
        plug.lualine-nvim
        plug.luasnip
        plug.markdown-preview-nvim
        plug.nui-nvim
        plug.none-ls-nvim
        plug.nvim-autopairs
        plug.nvim-base16
        plug.nvim-cmp
        plug.nvim-dap
        plug.nvim-dap-virtual-text
        plug.nvim-lint
        plug.nvim-lspconfig
        plug.nvim-metals
        plug.nvim-navic
        plug.nvim-tree-lua
        plug.nvim-web-devicons
        plug.other-nvim
        plug.plenary-nvim
        plug.symbols-outline-nvim
        plug.telescope-fzf-writer-nvim
        plug.telescope-nvim
        plug.telescope-symbols-nvim
        plug.tint-nvim
        plug.vim-commentary
        plug.vim-fugitive
        plug.vim-nix
        plug.vim-pencil
        plug.vim-repeat
        plug.vim-rhubarb
        plug.vim-surround
        plug.vim-wakatime
        plug.zen-mode-nvim
        plug.zk-nvim
      ];
  };

  programs.git = {
    enable = true;

    extraConfig = builtins.readFile ./home/git/.gitconfig;
  };

  home.file.".gitconfig.work".source = ./home/git/.gitconfig.work;

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    extraConfig = builtins.readFile ./home/tmux/.tmux.conf;
  };

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  # programs.firefox.enable = true;

  # programs.gh.enable = true;

  programs.htop.enable = true;

  xdg.configFile.nvim = {
    source = ./home/nvim;
    recursive = true;
  };

  xdg.configFile.kitty = {
    source = ./home/kitty;
    recursive = true;
  };

  xdg.configFile.i3 = {
    source = ./home/i3;
    recursive = true;
  };

  xdg.configFile.polybar = {
    source = ./home/polybar;
    recursive = true;
  };

  xdg.configFile.rofi = {
    source = ./home/rofi;
    recursive = true;
  };

  home.file.".gitignore".source = ./home/git/.gitignore-global;

}
