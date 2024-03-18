#!/bin/sh
# by https://dpnpinto.github.io

setxkbmap pt &
#xrdb ~/.Xresources &
nitrogen --restore &
#slstatus &
picom &
exec dwm