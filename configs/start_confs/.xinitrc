#
#!/bin/bash
#
# by https://dpnpinto.github.io

setxkbmap pt
xcompmgr &
feh --bg-center ~/.config/backimg/space_arch.png &
# dwmblocks & it starts with dwm
# picom -b # remover asterisco para ter transparencias, eu pessoalmente não gosto
exec dwm
