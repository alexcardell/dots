{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    lxappearance
    protonmail-desktop
  ];

  programs.lutris.enable = true;
}
