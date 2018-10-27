# Ansible managed personal system configuration

Shamelessly inspired by [wincent](https://github.com/wincent "Wincent")

### Roles
#### Dotfiles
Symlinks config files to the correct places. Where possible the cross-platform differences are handled with internal logic (shell/vim if/elses), and where not possible it is solved by templating.

Primary workflow consists of Vim, Zsh, and Tmux.

#### :construction: Pacman :construction:
Installs packages from pacman.

#### :construction: Homebrew :construction:
Installs packages from homebrew.

---------------------------

### Usage
Clone this repo and call `git submodule update --init --recursive` to install submodule dependencies (mostly vim plugins). Then call `./install`.
