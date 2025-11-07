{ ... }:
{

  ids.gids.nixbld = 350;

  homebrew = {
    enable = true;
    taps = [
      "smithy-lang/tap" # smithy-cli
      "flipt-io/brew"
    ];
    casks = [
      "alt-tab"
      "discord"
      "firefox"
      "malwarebytes"
      "obsidian"
      "docker-desktop"
      "todoist-app"
    ];
    brews = [
      "docker-credential-helper-ecr"
      "flipt"
      "smithy-cli"
      "whalebrew"
      # "terragrunt"
      # "tfenv"
    ];
  };

  # documentation.doc.enable = false;
}
