# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
}
