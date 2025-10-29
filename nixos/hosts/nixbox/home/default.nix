{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    lxappearance
    protonmail-desktop
    todoist-electron
  ];

  programs.lutris.enable = true;
}
