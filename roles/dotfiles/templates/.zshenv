# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
{% endif %}

{% if ansible_os_family == 'Archlinux' %}
{% endif %}

# Editor #
###########
VISUAL=nvim
EDITOR="${VISUAL}"

# Code #
########
CODEPATH=$HOME/Code
# golang
GOPATH=$CODEPATH/go

# zsh
ZDOTDIR=$HOME/.zsh

# Tools #
#########
# ripgrep
RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
