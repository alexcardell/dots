{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings = {
    secret-key-files = [
      # TODO put in sops
      "/etc/nix/homelab-builder-nixbox-signing-key.sec"
    ];
    substituters = [
      "https://cache.garnix.io"
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  networking.hostName = "nixbox"; # Define your hostname.

  networking.extraHosts = ''
    192.168.0.20 nixpad
  '';

  fileSystems."/mnt/music" = {
    device = "//nixpad/music";
    fsType = "cifs";
    options = [
      "guest"
      "ro"
      "x-systemd.automount"
      "noauto"
      "nofail"
      "x-systemd.idle-timeout=5min"
      "uid=1000"
      "gid=100"
      "file_mode=0444"
      "dir_mode=0555"
      "vers=3.0"
    ];
  };

  fileSystems."/mnt/media" =
    let
      credentialsFile = "/run/secrets/nixpad-samba";
    in
    {
      device = "//nixpad/media";
      fsType = "cifs";
      options = [
        "credentials=${credentialsFile}"
        "uid=1000"
        "gid=100"
        "vers=3.1.1"
        "x-systemd.automount"
        "noauto"
      ];
    };

  system.activationScripts.nixpad-samba-credentials.text =
    let
      samba-pw = lib.removeSuffix "\n" (builtins.readFile ../../secrets/samba-pw);
    in
    ''
      install -d -m 0755 /run/secrets
      umask 077
      {
        printf '%s\n' ${lib.escapeShellArg "username=alex"}
        printf '%s\n' ${lib.escapeShellArg "password=${samba-pw}"}
      } > /run/secrets/nixpad-samba
      chmod 0600 /run/secrets/nixpad-samba
    '';

  networking.interfaces.enp42s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    let
      name = lib.getName pkg;
    in
    builtins.elem name [
      "steam"
      "todoist-electron"
      "discord"
    ]
    || lib.hasPrefix "steam-" name
    || lib.hasPrefix "nvidia-" name
    || lib.hasPrefix "cuda-" name
    || lib.hasPrefix "cuda_" name
    || lib.hasPrefix "lib" name;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.lightdm = {
      background = ../../../media/BLACK_VII_desktop-3.jpg;
      greeters.gtk = {
        enable = true;
        theme = {
          package = pkgs.orchis-theme;
          name = "Orchis-Purple-Dark";
        };
      };
    };

    # screenSection = ''
    #   Option "MetaModes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    # '';
  };

  # security.pam.services.lightdm.enableGnomeKeyring = true;

  services.picom = {
    enable = true;
    vSync = true;
    # Keep a synchronised compositor in the presentation path.  Unredirecting
    # fullscreen windows lets games bypass Picom's VSync and tear under X11.
    # NVIDIA's GLX backend also needs the X Sync fence for reliable ordering.
    backend = "glx";
    settings = {
      unredir-if-possible = false;
      xrender-sync-fence = true;
    };
  };

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    # Steam's bubblewrap sandbox refuses to start beneath a gamescope binary
    # carrying file capabilities ("Unexpected capabilities but not setuid").
    capSysNice = false;
    # Native 1440p presentation at a fixed 60 Hz.  These are defaults, so a
    # game's Steam launch options only need: gamescope -f -- %command%
    args = [
      "-w"
      "2560"
      "-h"
      "1440"
      "-W"
      "2560"
      "-H"
      "1440"
      "-r"
      "60"
    ];
  };

  programs.steam = {
    enable = true;
    # package = pkgs.unstable.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs.unstable; [
      proton-ge-bin
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  # Enable USB wakeup for keyboard/mouse
  systemd.services.usb-wakeup = {
    description = "Enable USB wakeup for peripherals";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    script = ''
      # Enable wakeup for keyboard/mouse hub and its controller
      echo enabled > /sys/bus/usb/devices/3-1/power/wakeup 2>/dev/null || true
      echo enabled > /sys/bus/usb/devices/usb3/power/wakeup 2>/dev/null || true
      # Individual devices (already enabled, but ensure they stay enabled)
      echo enabled > /sys/bus/usb/devices/3-1.3/power/wakeup 2>/dev/null || true
      echo enabled > /sys/bus/usb/devices/3-1.4/power/wakeup 2>/dev/null || true
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  services.flatpak.enable = true;

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
    };
  };

  xdg.mime = {
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

}
