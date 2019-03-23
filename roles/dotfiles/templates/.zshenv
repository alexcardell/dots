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

# golang
GOPATH=$HOME/projects/go

# zsh
ZDOTDIR=$HOME/.zsh

# ripgrep
RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
