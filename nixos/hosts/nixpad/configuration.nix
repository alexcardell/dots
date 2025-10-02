{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./homelab.nix
  ];

  networking.hostName = "nixpad"; # Define your hostname.
  # networking.nameservers = [
  #   "1.1.1.1"
  #   "1.0.0.1"
  # ];
  networking.firewall.allowedTCPPorts = [
    8123 # home-assistant
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
