{ config, pkgs, ... }:

{

  # nix.extraOptions = ''
  #   experimental-features = nix-command flakes
  # '';

  # enable nix-darwin to manage home-manager
  # imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ pkgs.vim ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/dots/nix/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  # nix.package = pkgs.nixUnstable;

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  users.users.alexcard = {
    name = "alexcard";
    home = "/Users/alexcard";
  };

  # home-manager.users.alexcard = import ../home-manager;
}
