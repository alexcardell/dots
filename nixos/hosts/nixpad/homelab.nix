{ pkgs, ... }:
{

  imports =
    [
      ./homelab-compose.nix
      ./qbittorrent.nix
    ];

  # for sonarr with nixos-25.05
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  environment.systemPackages = with pkgs;[
    chkrootkit
    jellycli
    jellyfin-web
    lynis
    recyclarr
    unstable.jellyfin-ffmpeg
    qbittorrent-nox
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

  services.qbittorrent = {
    enable = true;
    port = 9009;
    openFirewall = true;
  };

  # services.flaresolverr = {
  #   enable = true;
  #   openFirewall = false;
  # };
}
