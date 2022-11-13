{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
    qbittorrent
    rofi
    vlc
    protonvpn-cli_2
    brightnessctl
  ];

  programs.firefox.enable = true;
}
