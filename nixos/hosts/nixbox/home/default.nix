{ config, pkgs, flake-inputs, ... }:
{
  # imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  home.packages = with pkgs; [
    cameractrls-gtk3
    pavucontrol
    lxappearance
    protonmail-desktop
    todoist-electron
    discord
    unstable.vicinae
    tor-browser
  ];

  programs.lutris.enable = true;

  services.flatpak.packages = [
    "org.mixxx.Mixxx"
  ];
}
