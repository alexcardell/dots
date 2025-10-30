{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    lxappearance
    protonmail-desktop
    todoist-electron
    discord
  ];

  programs.lutris.enable = true;
}
