{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sketchybar
    sketchybar-app-font
  ];
}
