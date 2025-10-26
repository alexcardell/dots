{ config, pkgs, ... }:
{
  home.packages =
    with pkgs;
    let
      polybar' = polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    in
    [
      anki
      unstable.bitwarden
      unstable.bitwarden-cli
      brightnessctl
      cava
      fastcompmgr
      feh
      killall
      polybar'
      unstable.protonvpn-cli_2
      unstable.protonvpn-gui
      rofi
      unstable.qbittorrent
      unstable.veracrypt
      unzip
      vlc
      wireguard-tools
      xclip
    ];

  programs.firefox.enable = true;

  services.redshift = {
    enable = true;
    latitude = 53.480759;
    longitude = -2.242631;
    tray = true;
  };
}
