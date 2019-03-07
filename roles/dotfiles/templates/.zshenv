# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
{% endif %}

{% if ansible_os_family == 'Archlinux' %}
{% endif %}

# Platform agnostic
# #################
# editors
VISUAL=nvim
EDITOR="${VISUAL}"

# node version manager
NVM_DIR="$HOME/.nvm"

# golang
GOPATH=$HOME/projects/go

# zsh
ZDOTDIR=$HOME/.zsh
REPORTTIME=1

# ripgrep
RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
