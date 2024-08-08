{ config, pkgs, nixpkgs-unstable, ... }:
{

  imports =
    [ 
      ./homelab-compose.nix
    ];

  environment.systemPackages = with pkgs;[
    # jellyfin
    jellycli
    jellyfin-web
    # jellyfin-ffmpeg
  ];

  services.jellyfin = {
    enable = true;
    # user = "alex";
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
  };

  services.readarr = {
    enable = true;
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  # services.flaresolverr = {
  #   enable = true;
  #   openFirewall = false;
  # };
}
