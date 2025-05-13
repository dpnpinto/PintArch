#
#!/bin/bash
#
# by https://dpnpinto.github.io

setxkbmap pt &
feh --bg-scale ~/.config/backimg/space_arch.png &
dwmblocks &
picom -b
exec dwm
