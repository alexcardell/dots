{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    lxappearance
  ];

  programs.lutris.enable = true;
}
