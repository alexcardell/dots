{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    aws-vault
    awscli2
    gh
    hiera-eyaml
    postgresql_16
    tenv
    # terragrunt
  ];
}
