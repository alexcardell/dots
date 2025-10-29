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
}
