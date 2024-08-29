{ ... }:
{

  homebrew = {
    enable = true;
    taps = [
      "smithy-lang/tap" # smithy-cli
      "flipt-io/brew"
    ];
    casks = [
      "firefox"
      "inso"
      "malwarebytes"
    ];
    brews = [
      "adr-tools"
      "docker-credential-helper-ecr"
      "smithy-cli"
      "whalebrew"
      "flipt"
      # "terragrunt"
      # "tfenv"
    ];
  };

  # documentation.doc.enable = false;
}
