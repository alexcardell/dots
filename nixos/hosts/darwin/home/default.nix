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
    adr-tools
    aws-vault
    awscli2
    gh
    hiera-eyaml
    pngpaste
    postgresql_16
    tenv
  ];

}
