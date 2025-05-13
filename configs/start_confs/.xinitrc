#
#!/bin/bash
#
# by https://dpnpinto.github.io

setxkbmap pt &
nitrogen --restore &
dwmblocks &
picom -b
exec dwm
