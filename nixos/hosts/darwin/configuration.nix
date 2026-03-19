{ config, pkgs, ... }:

{

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # enable nix-darwin to manage home-manager
  # imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
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

  # services.karabiner-elements = {
  #   enable = false;
  #   # use older karabiner-elements version
  #   # awaiting fix https://github.com/nix-darwin/nix-darwin/issues/1041
  #   package = pkgs.karabiner-elements.overrideAttrs (old: {
  #     version = "14.13.0";
  #
  #     src = pkgs.fetchurl {
  #       inherit (old.src) url;
  #       hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
  #     };
  #
  #     dontFixup = true;
  #   });
  # };

  # TODO this would be good but doesn't seem to work, hit an SSL issue before script runs
  # system.activationScripts.preActivation.text = ''
  #   if [ ! -f /etc/ssl/certs/zscaler-root-ca.pem ]; then
  #     echo 'ssl-ca-cert-fix: generating new zscaler cert
  #     security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
  #     security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
  #     cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
  #     sudo mv /tmp/ca_cert.pem /etc/ssl/certs/zscaler-root-ca.pem
  #   fi
  # '';

  nix.settings = {
    ssl-cert-file = "/etc/ssl/certs/zscaler-root-ca.pem";
  };

}
