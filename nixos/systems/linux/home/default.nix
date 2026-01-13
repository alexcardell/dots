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
      nur.repos.bandithedoge.waterfox-bin
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
      wineWowPackages.stable
      winetricks
      wireguard-tools
      xclip
    ];

  programs.firefox.enable = true;

  services.redshift = {
    enable = true;
    latitude = 51.480158;
    longitude = -2.5158927;
    tray = true;
  };
}
