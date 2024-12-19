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
      polybar'
      protonvpn-cli
      protonvpn-gui
      unstable.qbittorrent
      rofi
      unstable.veracrypt
      unzip
      vlc
      wireguard-tools
      xclip
    ];

  programs.firefox.enable = true;
}
