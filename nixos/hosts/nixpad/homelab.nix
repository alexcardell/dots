{ config, pkgs, nixpkgs-unstable, ... }:
{

  imports =
    [ 
      ./homelab-compose.nix
    ];

  environment.systemPackages = with pkgs;[
    jellycli
    jellyfin-web
    # jellyfin-ffmpeg
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

  services.jellyseerr =  {
    enable = true;
    openFirewall = true;
  };

  # services.flaresolverr = {
  #   enable = true;
  #   openFirewall = false;
  # };
}
