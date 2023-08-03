{ ... }:
{

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "inso"
    ];
    brews = [
      "docker-credential-helper-ecr"
      "whalebrew"
      "tfenv"
      "terragrunt"
    ];
  };
}
