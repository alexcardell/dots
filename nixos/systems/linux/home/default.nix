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
      protonvpn-cli_2
      qbittorrent
      rofi
      unzip
      vlc
      xclip
      unstable.veracrypt
    ];

  programs.firefox.enable = true;
}
