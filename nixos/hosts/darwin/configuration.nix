{ config, pkgs, ... }:

{

  # nix.extraOptions = ''
  #   experimental-features = nix-command flakes
  # '';

  # enable nix-darwin to manage home-manager
  # imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    kitty
    vim
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/dots/nixos/hosts/darwin/configuration.nix";

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.primaryUser = "alexcard";

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  users.users.alexcard = {
    name = "alexcard";
    home = "/Users/alexcard";
  };
}
