# Ansible managed personal system configuration

Sets up a Python virtual environment then runs Ansible roles based on the
current operating system.

Designed for macOS Mojave and Arch Linux.

## Roles

See role description files.

- :computer: [dotfiles](./roles/dotfiles/description)
- :package: [pacman](./roles/pacman/description)
- :coffee: [homebrew](./roles/homebrew/description)
- :keyboard: [code](./roles/code/description)
- :link: [yarn](./roles/yarn/description)

## Dependencies

- **Python 3:** Sets up the virtual environment. Ansible will be installed for
  you.

## Usage

1. Clone this repo.

1. `git submodule update --init --recursive` to install sub-module dependencies
(mostly Vim plugins).

1. `./run`

    This script accepts tags as arguments. With no arguments, it will run the
    `dotfiles` role.

    With arguments, it will run all roles matching that tag, e.g. `./run
    homebrew` will run the homebrew role.

    `./run all` will, unsurprisingly run all roles for the current platform.
