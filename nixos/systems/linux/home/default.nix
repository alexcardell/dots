{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    anki
    bitwarden
    bitwarden-cli
    brightnessctl
    protonvpn-cli_2
    qbittorrent
    rofi
    vlc
  ];

  programs.firefox.enable = true;
}
