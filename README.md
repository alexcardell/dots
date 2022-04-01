# alexcardell/dots

Formerly, an Ansible managed personal configuration setup for Arch Linux and macOS. Currently migrating to NixOS and nix-darwin.

## NixOS

### Usage

1. Get a NixOS install working. Requires nix > 2.4 and `experimental features = nix-command flakes` enabled in `/etc/nix/nix.conf`
1. Import GPG key 
1. Clone Repo
1. `git-crypt unlock`
1. Replace `./nix/nixos/hardware-configuration.nix` with the generated one: `/etc/nixos/hardware-configuration.nix` or `nixos-generate-config`
1. `cd nix && sudo nixos-rebuild --flake .#`

### Tasks

- [ ] Manage secrets: Evaluate sops-nix vs plain old git-crypt
- [ ] Rebuild neovim configuration in lua (and strip out some cruft)
- [ ] Evaluate managing neovim plugins in home-manager
- [ ] Migrate zsh and zsh plugins to home-manager
- [ ] Migrate tmux and tmux plugins to home-manager
- [ ] Support shared home-manager configuration between NixOS (nixpad branch) and nix-darwin (workmac branch)

## Ansible (Stale)

Sets up a Python virtual environment then runs Ansible roles based on the
current operating system.

Designed for macOS Mojave and Arch Linux.

### Roles

See role description files.

- :computer: [dotfiles](./roles/dotfiles/description)
- :package: [pacman](./roles/pacman/description)
- :coffee: [homebrew](./roles/homebrew/description)
- :keyboard: [code](./roles/code/description)
- :link: [yarn](./roles/yarn/description)

### Dependencies

- **Python 3:** Sets up the virtual environment. Ansible will be installed for
  you.

### Usage

1. Clone this repo.

1. `git submodule update --init --recursive` to install sub-module dependencies
(mostly Vim plugins).

1. `./run`

    This script accepts tags as arguments. With no arguments, it will run the
    `dotfiles` role.

    With arguments, it will run all roles matching that tag, e.g. `./run
    homebrew` will run the homebrew role.

    `./run all` will, unsurprisingly, run all roles for the current platform.
