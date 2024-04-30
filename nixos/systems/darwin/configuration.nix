{ ... }:
{

  homebrew = {
    enable = true;
    taps = [
      "smithy-lang/tap" # smithy-cli
    ];
    casks = [
      "firefox"
      "inso"
    ];
    brews = [
      "adr-tools"
      "docker-credential-helper-ecr"
      "smithy-cli"
      "whalebrew"
      # "terragrunt"
      # "tfenv"
    ];
  };

  # documentation.doc.enable = false;
}
