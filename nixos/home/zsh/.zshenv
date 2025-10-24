DEFAULT_PATH=$PATH
unset PATH

PATH=$PATH:$HOME/.bin
PATH=$PATH:$HOME/.local/bin

# some packages are installed
# via nix-darwin homebrew
PATH=$PATH:/opt/homebrew/bin

# TODO package up anything here as nix flake
# PATH=$PATH:$HOME/.yarn/bin

# PATH=$PATH:node_modules/.bin

PATH=$PATH:$HOME/.local/node/global/bin

PATH=$DEFAULT_PATH:$PATH

typeset -U PATH
export PATH
export NODE_PATH=$HOME/.local/node/global/lib/node_modules
