# {{ ansible_managed }}

# zsh
export ZDOTDIR=$HOME/.zsh
export HISTSIZE=10000
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
# maven
export M2_HOME=$HOME
# Node
export NODE_ENV=development

# Tools #
#########
# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
# fzf
export FZF_DEFAULT_COMMAND='rg --files --follow'
# Helm
export TILLER_NAMESPACE=tiller

{% if darwin %}
# Darwin #
##########
{% if work %}
## Work ##
export WORKPATH=$HOME/Work
{% endif %}
{% endif %}
{% if arch %}
# Linux #
#########
{% endif %}

# Path
DEFAULT_PATH=$PATH
unset PATH

PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
# Go
PATH=$PATH:$GOPATH/bin
# Rust
PATH=$PATH:$HOME/.cargo/bin
# Node
PATH=$PATH:$HOME/.yarn/bin
# Zsh
PATH=$PATH:$HOME/.zsh/bin
# Manually installed executables
PATH=$PATH:$HOME/.bin
PATH=$PATH:$HOME/.local/bin

## TEMP to get neovim from source
PATH=$PATH:$HOME/Code/vendor/neovim/build/bin

# Current directory node_modules
PATH=$PATH:node_modules/.bin

{% if darwin %}
# Darwin #
##########
{% if work %}
## Work ##
PATH=$PATH:/usr/local/Cellar/thrift/0.12.0/bin
{% endif %}
{% endif %}

# Add defaults back
PATH=$DEFAULT_PATH:$PATH

typeset -U PATH
export PATH

# AWS
export AWS_ACCESS_KEY_ID=$(type aws &>/dev/null && aws --profile default configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(type aws &>/dev/null && aws --profile default configure get aws_secret_access_key)

[[ -f ${ZDOTDIR}/.private.zshenv ]] && . ${ZDOTDIR}/.private.zshenv
