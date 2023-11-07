# `alexcardell/dots`

Personal configuration for NixOS / `nix-darwin` systems

## Usage

1. Get a NixOS install working. Requires nix > 2.4 and `experimental features = nix-command flakes` enabled in `/etc/nix/nix.conf`
1. Import GPG key 
1. Clone repository
1. `git-crypt unlock`
1. Replace `./nix/nixos/hardware-configuration.nix` with the generated one: `/etc/nixos/hardware-configuration.nix` or `nixos-generate-config`
1. `cd nix && sudo nixos-rebuild --flake .#`
