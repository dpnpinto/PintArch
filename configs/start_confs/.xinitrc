#
#!/bin/bash
#
# by https://dpnpinto.github.io

setxkbmap pt
feh --bg-center ~/.config/backimg/space_arch.png &
dwmblocks &
picom -b
exec dwm
