{
  config,
  pkgs,
  lib,
  ...
}:
{

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
    ];

  home.packages = with pkgs; [
    aws-vault
    awscli2
    gh
    hiera-eyaml
    postgresql_16
    tenv
    # terragrunt
    todoist-electron
  ];

}
