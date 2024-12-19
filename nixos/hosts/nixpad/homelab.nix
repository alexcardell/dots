{ config, pkgs, nixpkgs-unstable, ... }:
{

  imports =
    [ 
      ./homelab-compose.nix
    ];

  environment.systemPackages = with pkgs;[
    jellycli
    jellyfin-web
    unstable.jellyfin-ffmpeg
    recyclarr
  ];

  # power management
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80; 
    };
  };

  services.jellyfin = {
    enable = true;
    package = pkgs.unstable.jellyfin;
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
    openFirewall = true;
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
  };

  services.jellyseerr =  {
    enable = true;
    openFirewall = true;
  };

  # services.flaresolverr = {
  #   enable = true;
  #   openFirewall = false;
  # };
}
