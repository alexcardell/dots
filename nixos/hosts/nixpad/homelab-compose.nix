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
  virtualisation.oci-containers.containers."flaresolverr" = {
    image = "flaresolverr/flaresolverr";
    ports = [
      "8191:8191/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-flaresolverr" = {
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
  virtualisation.oci-containers.containers."homarr" = {
    image = "ghcr.io/ajnart/homarr:latest";
    volumes = [
      "/home/alex/dots/nixos/hosts/nixpad/home/homarr/configs:/app/data/configs:rw"
      "/home/alex/dots/nixos/hosts/nixpad/home/homarr/data:/data:rw"
      "/home/alex/dots/nixos/hosts/nixpad/home/homarr/icons:/app/public/icons:rw"
    ];
    ports = [
      "7575:7575/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-homarr" = {
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
