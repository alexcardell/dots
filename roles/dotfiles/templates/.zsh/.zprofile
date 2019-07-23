# {{ ansible_managed }}

{% if arch %}
setxkbmap gb # potentially needs moving to zshrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
{% endif %}
