# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."calibre-web-automated" = {
    image = "crocodilestick/calibre-web-automated:latest";
    environment = {
      "HARDCOVER_TOKEN" = "your_hardcover_api_key_here";
      "NETWORK_SHARE_MODE" = "false";
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "GB";
    };
    volumes = [
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/config:/config:rw"
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/ingest:/cwa-book-ingest:rw"
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/library:/calibre-library:rw"
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/plugins:/config/.config/calibre/plugins:rw"
    ];
    ports = [
      "8083:8083/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-calibre-web-automated" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."calibre-web-automated-book-downloader" = {
    image = "ghcr.io/calibrain/calibre-web-automated-book-downloader:latest";
    environment = {
      "AA_BASE_URL" = "https://annas-archive.li";
      "APP_ENV" = "prod";
      "BOOK_LANGUAGE" = "en";
      "CWA_DB_PATH" = "/auth/app.db";
      "DOWNLOAD_PROGRESS_UPDATE_INTERVAL" = "5";
      "EXT_BYPASSER_URL" = "http://127.0.0.1:8191";
      "FLASK_PORT" = "8084";
      "GID" = "100";
      "LOG_LEVEL" = "info";
      "MAX_CONCURRENT_DOWNLOADS" = "3";
      "TZ" = "Europe/London";
      "UID" = "1000";
      "USE_BOOK_TITLE" = "true";
    };
    volumes = [
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/config/app.db:/auth/app.db:ro"
      "/home/alex/dots/nixos/hosts/nixpad/home/cwa/ingest:/cwa-book-ingest:rw"
    ];
    ports = [
      "8084:8084/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-calibre-web-automated-book-downloader" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
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
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."grafana" = {
    image = "grafana/grafana:latest";
    environment = {
      "GF_SERVER_HTTP_PORT" = "3333";
    };
    volumes = [
      "homelab_grafana_storage:/var/lib/grafana:rw"
    ];
    ports = [
      "3333:3333/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.services."docker-grafana" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-volume-homelab_grafana_storage.service"
    ];
    requires = [
      "docker-volume-homelab_grafana_storage.service"
    ];
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
      "/var/run/docker.sock:/var/run/docker.sock:rw"
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
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };
  virtualisation.oci-containers.containers."home-assistant" = {
    image = "ghcr.io/home-assistant/home-assistant:stable";
    volumes = [
      "/home/alex/dots/nixos/hosts/nixpad/home/home-assistant:/config:rw"
      "/var/run/bluetooth:/var/run/bluetooth:rw"
      "/var/run/dbus:/var/run/dbus:rw"
    ];
    ports = [
      "8123:8123/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--device=/dev/ttyUSB0:/dev/ttyUSB0:rwm"
      "--network=host"
    ];
  };
  systemd.services."docker-home-assistant" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-homelab-root.target"
    ];
    wantedBy = [
      "docker-compose-homelab-root.target"
    ];
  };

  # Volumes
  systemd.services."docker-volume-homelab_grafana_storage" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect homelab_grafana_storage || docker volume create homelab_grafana_storage
    '';
    partOf = [ "docker-compose-homelab-root.target" ];
    wantedBy = [ "docker-compose-homelab-root.target" ];
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
