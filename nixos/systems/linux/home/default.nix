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
      flameshot
      gparted
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

  xdg.configFile.i3 = {
    source = ../../../home/i3;
    recursive = true;
  };

  xdg.configFile.polybar = {
    source = ../../../home/polybar;
    recursive = true;
  };

  xdg.configFile.rofi = {
    source = ../../../home/rofi;
    recursive = true;
  };

  xdg.configFile.vicinae = {
    source = ../../../home/vicinae;
    recursive = true;
  };

}
