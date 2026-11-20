{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.pangolin-client;
in
{
  options.services.pangolin-client = {
    enable = lib.mkEnableOption "the Pangolin desktop client and background daemon";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ../pkgs/pangolin-client { };
      description = "Pangolin client package to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."xdg/autostart/pangolin-client-autostart.desktop".source =
      "${cfg.package}/etc/xdg/autostart/pangolin-client-autostart.desktop";

    boot.kernelModules = [ "tun" ];

    systemd.services.pangolin-client = {
      description = "Pangolin client background service";
      documentation = [ "https://docs.pangolin.net" ];
      # The daemon's local IPC must be available at login, even while the
      # network is still coming up. Tunnels connect once the UI attaches.
      after = [ "network.target" ];
      before = [ "display-manager.service" ];
      wantedBy = [ "multi-user.target" ];
      path = [
        # systemd also ships a resolvconf shim, which requires systemd-resolved.
        # Prefer the resolver configured by NixOS (openresolv on nixbox).
        config.networking.resolvconf.package
        pkgs.systemd
        pkgs.nftables
        pkgs.iptables
      ];
      postStart = ''
        for attempt in {1..100}; do
          if test -S /run/pangolin-client/manager.sock; then
            exit 0
          fi
          sleep 0.1
        done
        echo "Pangolin daemon did not create its IPC socket" >&2
        exit 1
      '';
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe cfg.package} --daemon";
        Restart = "on-failure";
        RestartSec = 2;
        # Let the daemon stop tunnels and restore DNS/routes before killing children.
        KillMode = "mixed";
        TimeoutStopSec = 45;
        RuntimeDirectory = "pangolin-client";
        RuntimeDirectoryMode = "0755";
        StateDirectory = "pangolin-client";
        StateDirectoryMode = "0700";
        LogsDirectory = "pangolin-client";
        LogsDirectoryMode = "0755";
      };
    };
  };
}
