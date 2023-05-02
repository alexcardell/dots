{ config, pkgs, ... }:
{ 
  home.packages = with pkgs; [
    aws-vault
    awscli2
    gh
    hiera-eyaml
    postgresql_13
    terraform
    terragrunt
  ];
}
