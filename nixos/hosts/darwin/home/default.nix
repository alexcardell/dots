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

  home.packages = with pkgs.unstable; [
    # devpod-desktop
    adr-tools
    aws-vault
    awscli2
    bashInteractive
    coreutils-prefixed
    devpod
    gh-dash
    google-cloud-sdk
    hiera-eyaml
    pngpaste
    postgresql_16
    postman
    pkgs.raycast
    slack
  ];

}
