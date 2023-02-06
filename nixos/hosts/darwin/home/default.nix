{ config, pkgs, ... }:
{ 
  home.packages = with pkgs; [
    aws-vault
    awscli2
    gh
    terraform
    terragrunt
  ];
}
