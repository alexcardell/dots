{ pkgs, ... }:
let
  tmux-agent-status = pkgs.callPackage ./tmux/plugins/tmux-agent-status.nix { };
  tmux-agent-status-root = builtins.dirOf tmux-agent-status.rtp;
  codex-agent-status-hook = event: {
    type = "command";
    command = "${pkgs.bashNonInteractive}/bin/bash ${tmux-agent-status-root}/hooks/codex-hook.sh ${event}";
    timeout = 3;
  };
in
{
  imports = [
    ./nvim.nix
  ];

  manual.html.enable = false;
  manual.manpages.enable = false;
  manual.json.enable = false;

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # unstable.bitwarden-desktop
    actionlint
    bitwarden-cli
    bruno-cli
    compose2nix
    coursier
    entr
    fd
    gh
    git
    git-crypt
    git-filter-repo
    gnupg
    jj
    jq
    kitty
    mcp-nixos
    nerd-fonts.sauce-code-pro
    nodejs_22
    pi-coding-agent
    ripgrep
    sbt
    shellcheck
    tenv
    unixtools.watch
    unstable.bruno
    unstable.jira-cli-go
    unstable.languagetool-rust
    unstable.ollama
    unstable.scala-cli
    unstable.sloth
    unstable.spr
    vale
    xdg-ninja
    yamllint
    yq-go
    zk
    zizmor
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };

  home.sessionVariables = {
    # workaround to allow kitty to run darwin-rebuild
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      ZVM_VI_ESCAPE_BINDKEY = "jk";
    };

    envExtra =
      let
        isDarwin = pkgs.stdenv.isDarwin;
        baseEnv = builtins.readFile ./zsh/.zshenv;
        darwinEnv = ''
          ${builtins.readFile ./zsh/.zshenv.darwin}
          export SNYK_TOKEN="${pkgs.lib.removeSuffix "\n" (builtins.readFile ../secrets/snyk-ls-token)}"
        '';
      in
      if isDarwin then baseEnv + "\n" + darwinEnv else baseEnv;
    initContent = builtins.readFile ./zsh/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  home.file.".zsh" = {
    source = ./zsh/.zsh;
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

  # programs.git = {
  #   enable = true;
  #   settings = {};
  # };

  home.file.".gitconfig".source = ./git/.gitconfig;
  home.file.".gitconfig.work".source = ./git/.gitconfig.work;
  home.file.".gitignore".source = ./git/.gitignore-global;

  home.file.".codex/hooks.json".text = builtins.toJSON {
    description = "Report Codex lifecycle events to tmux-agent-status.";
    hooks = {
      SessionStart = [
        {
          matcher = "startup|resume";
          hooks = [ (codex-agent-status-hook "SessionStart") ];
        }
      ];
      UserPromptSubmit = [
        {
          hooks = [ (codex-agent-status-hook "UserPromptSubmit") ];
        }
      ];
      PreToolUse = [
        {
          matcher = "Bash";
          hooks = [ (codex-agent-status-hook "PreToolUse") ];
        }
      ];
      Stop = [
        {
          hooks = [ (codex-agent-status-hook "Stop") ];
        }
      ];
    };
  };

  programs.tmux = {
    enable = true;
    tmuxp.enable = true;

    plugins = [
      {
        plugin = tmux-agent-status;
        extraConfig = ''
          set-environment -g TMUX_AGENT_STATUS_BASH "${pkgs.bashNonInteractive}/bin/bash"
          set -g @agent-park-key "P"
        '';
      }
    ];

    extraConfig =
      let
        isDarwin = pkgs.stdenv.isDarwin;
        commonConfig = builtins.readFile ./tmux/.tmux.conf;
        darwinConfig = builtins.readFile ./tmux/.tmux.darwin.conf;
      in
      if isDarwin then darwinConfig + "\n" + commonConfig else commonConfig;
  };

  xdg.configFile.tmuxp = {
    source = ./tmux/tmuxp;
    recursive = true;
  };

  xdg.configFile.tmux-scripts = {
    source = ./tmux/scripts;
    recursive = true;
  };

  programs.fzf = {
    enable = true;
    # zsh-vi-mode breaks this so it's handled in zshrc
    enableZshIntegration = false;
  };

  programs.htop.enable = true;

  programs.nh.enable = true;

  xdg.configFile.kitty = {
    source = ./kitty;
    recursive = true;
  };

}
