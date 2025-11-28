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
      nur.repos.forkprince.waterfox-bin
      orchis-theme
      polybar'
      rofi
      sops
      themechanger
      unstable.protonvpn-gui
      unstable.qbittorrent
      unstable.veracrypt
      unzip
      vlc
      wireguard-tools
      xclip
      wineWowPackages.stable
      winetricks
    ];

  # programs.firefox.enable = true;

  services.redshift = {
    enable = true;
    latitude = 53.480759;
    longitude = -2.242631;
    tray = true;
  };
}
