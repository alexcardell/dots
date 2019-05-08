# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
{% endif %}

{% if ansible_os_family == 'Archlinux' %}
{% endif %}

# zsh
export ZDOTDIR=$HOME/.zsh
export HISTSIZE=10000
export HISTFILE="$ZDOTDIR/.zhistory"
export SAVEHIST=$HISTSIZE

# Editor #
###########
export VISUAL=nvim
export EDITOR="${VISUAL}"

# Code #
########
export CODEPATH=$HOME/Code
# golang
export GOPATH=$CODEPATH/go

# Tools #
#########
# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
# fzf
export FZF_DEFAULT_COMMAND='rg --files --follow'
# Helm
export TILLER_NAMESPACE=tiller
