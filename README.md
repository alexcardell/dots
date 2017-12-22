# Ansible managed personal system configuration
## Some context
- Pre-2017: Happily working exclusively on an Arch Linux system.
Dotfiles managed through various means over the years, starting with no version
control, to manual symlinks, to GNU Stow.
(A setup heavily inspired by [these
screencasts.)](https://www.youtube.com/channel/UCXPHFM88IlFn68OmLwtPmZA/feed)
- Late 2017 to Present: Having to balance Arch at home and MacOS at work,
plus a desire to have more and more of both system setups under version control.
Stow won't cut it, so in comes Ansible.

### Dotfiles
Primary workflow consists of:
- Vim
- Zsh
- Tmux
