{ config, pkgs, ... }:
{
  home.packages = with pkgs;
    let
      polybar' = polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    in
    [
      anki
      bitwarden
      bitwarden-cli
      brightnessctl
      cava
      fastcompmgr
      feh
      killall
      polybar'
      protonvpn-cli
      protonvpn-gui
      rofi
      unstable.qbittorrent
      unstable.veracrypt
      unzip
      vlc
      wireguard-tools
      xclip
    ];

  programs.firefox.enable = true;
}
