# Ansible managed personal system configuration

Sets up a Python virtual environment then runs Ansible roles based on the current operating system. 

Designed for MacOS Mojave and Arch Linux.

## Roles
#### Dotfiles
Symlinks config files to the correct places. Where possible the cross-platform differences are handled with internal logic (shell/vim if/elses), and where not possible it is solved by templating.

Primary workflow consists of Vim, Zsh, and Tmux.

#### Pacman (Arch)
Installs packages from [pacman](https://wiki.archlinux.org/index.php/pacman).

#### Homebrew (MacOS)
Installs packages from [homebrew](https://brew.sh/).

## Dependencies
- Python 3 -- Sets up the virtual environment. Ansible will be installed for you. 

## Usage
1. Clone this repo.
1. `git submodule update --init --recursive` to install submodule dependencies (mostly vim plugins). 
1. `./run`

    This script accepts tags as arguments. With no arguments, it will run the `dotfiles` role. With arguments, it will run all roles matching that tag, e.g. `./run homebrew` will run the homebrew role.
