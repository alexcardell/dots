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
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [
        # systemd also ships a resolvconf shim, which requires systemd-resolved.
        # Prefer the resolver configured by NixOS (openresolv on nixbox).
        config.networking.resolvconf.package
        pkgs.systemd
        pkgs.nftables
        pkgs.iptables
      ];
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
