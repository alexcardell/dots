# {{ ansible_managed }}

{% if ansible_os_family == 'Darwin' %}
# Darwin platform
# ###############
{% endif %}

# Platform agnostic
# #################
VISUAL=nvim
EDITOR="${VISUAL}"

# use project specific node modules
PATH=node_modules/.bin:$PATH

NVM_DIR="$HOME/.nvm"

GOPATH=$HOME/projects/go

ZDOTDIR=$HOME/.zsh
