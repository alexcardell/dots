{ config, pkgs, flake-inputs, ... }:
{
  # imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  home.packages = with pkgs; [
    cameractrls-gtk3
    discord
    lxappearance
    pavucontrol
    protonmail-desktop
    todoist-electron
    tor-browser
    unstable.eww
    unstable.vicinae
  ];

  programs.lutris.enable = true;

  services.flatpak.packages = [
    "org.mixxx.Mixxx"
  ];
}
