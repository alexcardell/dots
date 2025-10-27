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
      brightnessctl
      cava
      fastcompmgr
      feh
      killall
      orchis-theme
      polybar'
      rofi
      themechanger
      unstable.bitwarden
      unstable.bitwarden-cli
      unstable.protonvpn-cli_2
      unstable.protonvpn-gui
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
