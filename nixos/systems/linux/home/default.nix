{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    rofi
  ];

  programs.firefox.enable = true;
}
