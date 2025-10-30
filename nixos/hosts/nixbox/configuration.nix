{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "nixbox"; # Define your hostname.

  networking.interfaces.enp42s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "todoist-electron"
      "discord"
    ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  programs.steam = {
    enable = true;
    # package = pkgs.unstable.steam;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Enable USB wakeup for keyboard/mouse
  systemd.services.usb-wakeup = {
    description = "Enable USB wakeup for peripherals";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    script = ''
      # Enable wakeup for keyboard/mouse hub and its controller
      echo enabled > /sys/bus/usb/devices/3-1/power/wakeup 2>/dev/null || true
      echo enabled > /sys/bus/usb/devices/usb3/power/wakeup 2>/dev/null || true
      # Individual devices (already enabled, but ensure they stay enabled)
      echo enabled > /sys/bus/usb/devices/3-1.3/power/wakeup 2>/dev/null || true
      echo enabled > /sys/bus/usb/devices/3-1.4/power/wakeup 2>/dev/null || true
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
