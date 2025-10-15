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

  networking.firewall.allowedTCPPorts = [
    80 # nginx
    443 # nginx
    8123 # home-assistant
    7575 # homarr
    3333 # grafana
    5030 # slskd
    8083 # cwa
    8084 # cwa-book-downloader
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
