# {{ ansible_managed }}

{% if ansible_os_family == 'Archlinux' %}
  setxkbmap gb # potentially needs moving to zshrc
  startx
{% endif %}
