{ ... }:
{

  ids.gids.nixbld = 350;

  homebrew = {
    enable = true;
    taps = [
      "smithy-lang/tap" # smithy-cli
      "flipt-io/brew"
      "snyk/tap"
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
      "snyk"
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
