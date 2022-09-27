{ ... }:
{
  home.packages = [
    bitwarden
    bitwarden-cli
    rofi
  ];

  programs.firefox.enable = true;
}
