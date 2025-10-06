{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./homelab.nix
  ];

  networking.hostName = "nixpad";

  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # networking.nameservers = [
  #   "1.1.1.1"
  #   "1.0.0.1"
  # ];

  networking.firewall.allowedTCPPorts = [
    8123 # home-assistant
    7575 # homarr
    3333 # grafana
  ];

  hardware.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.logind = {
    extraConfig = ''
      HandleLidSwitchExternalPower=ignore
      HandleLidSwitchDocked=ignore
    '';
  };
}
