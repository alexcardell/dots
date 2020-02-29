[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset -b
unclutter & \
picom & \
  exec i3
