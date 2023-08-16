{ ... }:
{

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "inso"
    ];
    brews = [
      "adr-tools"
      "docker-credential-helper-ecr"
      # "terragrunt"
      # "tfenv"
      "whalebrew"
    ];
  };
}
