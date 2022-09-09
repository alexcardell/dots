export WORKPATH=$HOME/itv
export ZK_NOTEBOOK_DIR=$WORKPATH/notes

DEFAULT_PATH=$PATH
unset PATH

PATH=$PATH:$HOME/.bin
PATH=$PATH:$HOME/.local/bin

# TODO package up anything here as nix flake
PATH=$PATH:$HOME/.yarn/bin

PATH=$PATH:node_modules/.bin

PATH=$DEFAULT_PATH:$PATH

typeset -U PATH
export PATH
