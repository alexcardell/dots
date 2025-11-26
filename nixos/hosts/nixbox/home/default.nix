{ config, pkgs, flake-inputs, ... }:
{
  # imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  home.packages = with pkgs; [
    pavucontrol
    lxappearance
    protonmail-desktop
    todoist-electron
    discord
    unstable.vicinae
  ];

  programs.lutris.enable = true;

  services.flatpak.packages = [
    "org.mixxx.Mixxx"
  ];
}
