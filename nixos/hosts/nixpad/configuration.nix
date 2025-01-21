{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./homelab.nix
    ];

  networking.hostName = "nixpad"; # Define your hostname.
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  networking.firewall.allowedTCPPorts = [
    8123 # home-assistant
    9999 # qbittorrent
  ];

}
