# {{ ansible_managed }}

{% if arch %}
  setxkbmap gb # potentially needs moving to zshrc
  startx
{% endif %}
