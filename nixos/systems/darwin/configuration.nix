{ ... }:
{

  homebrew = {
    enable = true;
    taps = [
      "smithy-lang/tap"
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
}
