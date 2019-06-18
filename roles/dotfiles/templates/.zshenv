# {{ ansible_managed }}

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

{% if ansible_os_family == 'Darwin' %}
# Darwin
{% endif %}
{% if ansible_os_family == 'Archlinux' %}
# Linux
{% endif %}

# Path
DEFAULT_PATH=$PATH
unset PATH

PATH=$HOME/.bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:node_modules/.bin
# PATH=$PATH:$HOME/.fnm
PATH=$PATH:$GOPATH/bin

# Add defaults back
PATH=$PATH:$DEFAULT_PATH

typeset -U PATH
export PATH

# AWS
export RW_AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id)
export RW_AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key)
