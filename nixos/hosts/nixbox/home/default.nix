{
  config,
  pkgs,
  flake-inputs,
  ...
}:
{
  # imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];

  programs.nh.osFlake = "${config.home.homeDirectory}/dots";

  home.packages = with pkgs; [
    cameractrls-gtk3
    discord
    lm_sensors
    lxappearance
    mangohud
    nautilus
    nvtopPackages.nvidia
    pavucontrol
    tor-browser
    unstable.eww
    unstable.protonmail-desktop
    unstable.todoist-electron
    unstable.vicinae
    vlc
    wineWow64Packages.stable
    winetricks
    yad
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
