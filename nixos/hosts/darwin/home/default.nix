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
    adr-tools
    aws-vault
    awscli2
    coreutils-prefixed
    devpod
    # devpod-desktop
    gh-dash
    google-cloud-sdk
    hiera-eyaml
    pngpaste
    postgresql_16
    raycast
    slack
  ];

}
