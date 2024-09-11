{ ... }:
{

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
    ];
    brews = [
      "adr-tools"
      "docker-credential-helper-ecr"
      "flipt"
      "smithy-cli"
      "whalebrew"
      "terragrunt"
      "tfenv"
    ];
  };

  # documentation.doc.enable = false;
}
