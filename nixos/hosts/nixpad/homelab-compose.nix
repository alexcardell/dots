# Auto-generated using compose2nix v0.2.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "jellyfin/jellyfin";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
    };
    volumes = [
      "/mnt/containers/jellyfin/config/:/config:rw"
      "/mnt/media/Movies/:/mnt/media/Movies:rw"
      "/mnt/media/Shows/:/mnt/media/Shows:rw"
    ];
    ports = [
      "8096:8096/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-jellyfin" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."prowlarr" = {
    image = "lscr.io/linuxserver/prowlarr:latest";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
    };
    volumes = [
      "/mnt/containers/prowlarr/config/:/config:rw"
    ];
    ports = [
      "9696:9696/tcp"
    ];
    dependsOn = [
      "sonarr"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-prowlarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."sonarr" = {
    image = "lscr.io/linuxserver/sonarr:latest";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
    };
    volumes = [
      "/mnt/containers/sonarr/config/:/config:rw"
      "/mnt/media/Downloads:/mnt/media/Downloads:rw"
      "/mnt/media/Shows:/mnt/media/Shows:rw"
    ];
    ports = [
      "8989:8989/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-sonarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-homelab-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
