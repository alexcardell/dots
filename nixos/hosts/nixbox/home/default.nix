{ config, pkgs, flake-inputs, ... }:
{
  # imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  home.packages = with pkgs; [
    cameractrls-gtk3
    discord
    lxappearance
    nautilus
    pavucontrol
    protonmail-desktop
    todoist-electron
    tor-browser
    unstable.eww
    unstable.vicinae
  ];

  programs.lutris.enable = true;

  services.flatpak = {
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    packages = [
      "org.mixxx.Mixxx"
    ];

    overrides = {
      "org.mixxx.Mixxx".Context = {
        filesystems = [
          "/mnt/usb"
        ];
      };
    };
  };
}
