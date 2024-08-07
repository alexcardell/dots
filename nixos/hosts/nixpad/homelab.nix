{ config, pkgs, ... }:
{

  imports =
    [ 
      ./homelab-compose.nix
    ];
  # environment.systemPackages = with pkgs;[
  #   # jellyfin
  #   jellycli
  #   jellyfin-web
  #   # jellyfin-ffmpeg
  # ];
  # services.jellyfin = {
  #   enable = true;
  #   # user = "alex";
  # };
  # services.sonarr.enable = true;
  # services.radarr.enable = true;
  # services.lidarr.enable = true;
  # services.prowlarr.enable = true;
}
