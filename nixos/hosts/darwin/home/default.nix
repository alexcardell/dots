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
    coreutils-prefixed
    devpod
    devpod-desktop
    gh-dash
    google-cloud-sdk
    hiera-eyaml
    n8n
    pngpaste
    postgresql_16
    raycast
    slack
  ];

}
