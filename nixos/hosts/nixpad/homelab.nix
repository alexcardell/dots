{ config, pkgs, ... }:
{
  services.jellyfin.enable = true;
  services.sonarr.enable = true;
  services.radarr.enable = true;
  services.lidarr.enable = true;
  services.prowlarr.enable = true;
}
