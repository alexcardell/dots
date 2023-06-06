#!/bin/bash

# scrot -o /tmp/screen.png
# convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
# convert /tmp/screen.png ~/Pictures/archlinux-small.png -gravity center -composite -matte /tmp/screen.png
i3lock -t -i $1
# rm /tmp/screen.png
