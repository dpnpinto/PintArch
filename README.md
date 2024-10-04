# PintArch - My personal instalation of [Arch Linux](https://archlinux.org)
-------------------------------------------------------------------------
#                               **[PintArch](https://github.com/dpnpinto/PintArch/) - Ain't got no teeth, ain't got cavities.**
- To run just use **curl https://raw.githubusercontent.com/dpnpinto/PintArch/main/install.sh | sh**
- Or just do it yourself **loakeys pt-laint1**, **pacman -Sy git** and **git clone https://github.com/dpnpinto/PintArch**, the instalation script is the file **PintArch.sh** 
- Note: remember this is made by me to me, use at your own risk, Allways changing something here.
-------------------------------------------------------------------------
#                      **https://dpnpinto.github.io**
-------------------------------------------------------------------------
## I designed this version of PintArch but, in reality, it is the simplified installation of my [Arch Linux](https://archlinux.org).
## It is not a pure Linux version on top of the [kernel](https://kernel.org), but, with the same mentality as [Linus Torvalds](https://github.com/torvalds/linux), I needed a version of an operating system for my [Workstation](https://en.wikipedia.org/wiki/Workstation) that met my needs to be light, simple, secure, and flexible.
## As a 'purist' I prefer base distributions rather than the ones 'based on'. I've tested a lot of them just to see how they work, naturally, they have been set aside.
## In my opinion, the [Arch Linux](https://archlinux.org) distribution is perfect for this. It is one of the best Linux distributions for desktop use, and for what I need, because::

* It is very, allways, up-to-date distribution ([Rolling Release](https://en.wikipedia.org/wiki/Rolling_release))
* It has a large community of very dedicated people https://gitlab.archlinux.org/archlinux
* It allows me to install everything I want (I don't know of any software that I can't get to work on Arch)
* It is completely modular and adaptable to the needs of any user
* It always has the latest updates https://wiki.archlinux.org/title/ArchWiki:About
* It has a very well-documented source of knowledge (Arch Wiki) https://wiki.archlinux.org
* It has the best open repository from a Linux community (AUR) https://aur.archlinux.org
--------------------------------------------------------------------------
#         Software packages used in this version of [Arch Linux](https://archlinux.org)

## System Level
* [grub](https://www.gnu.org/software/grub/) - Boot  loader that I use
* [base](https://archlinux.org/packages/core/any/base/) - Base Linux package for Arch Linux
* [base-devel](https://archlinux.org/packages/core/any/base-devel/) - Base developer package
* [Systemd](https://systemd.io) - Yes I like that Arch Linux use it, I use sockets in my workstation every time I can so...
* [linux](https://archlinux.org/packages/core/x86_64/linux/) - Linux kernel
* [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) - Firmware files
* [networkmanager](https://www.networkmanager.dev) - The only thing that you need for network management
* [pipewire](https://pipewire.org) - Get all the sound that you deserve in a computer
## System Level with Gui
* [nitrogen](https://github.com/l3ib/nitrogen) - Background image management
* [picom](https://github.com/yshui/picom) - Transparency management
* [lxappearance](https://github.com/lxde/lxappearance) - Get icons and fancy stuff management.
* [rofi](https://github.com/davatorium/rofi) - Use for starting aplications in the GUI
* [xorg-server](https://www.x.org/wiki/) - Yes, still using the most popular display server
* [PintoDWM](https://github.com/dpnpinto/PintoDWM) - My DWM (Dinamic Windows Management)
* [PintoST](https://github.com/dpnpinto/PintoST) - My terminal, ST (Simple Terminal)
* [PintoDWMBlocks](https://github.com/dpnpinto/PintoDWMBlocks) - My task bar based on DWMBlocks
## At user level
* [maim](https://github.com/naelstrof/maim) - Make image software, I use to screenshot. 
* [vim](https://www.vim.org) - The best editor
* [pcmanfm](https://github.com/lxqt/pcmanfm-qt) - GUI light file manager
* [lf](https://github.com/gokcehan/lf) - Terminal file manager
* [fastfetch](https://github.com/fastfetch-cli/fastfetch) - Show in a nice what your config
* [htop](https://htop.dev) e [btop](https://github.com/aristocratos/btop) - Visualize system resorces
* [nvtop](https://github.com/Syllo/nvtop) - visualize nvidia resorces (I use a Nvidia Card) 
* [code](https://github.com/microsoft/vscode) -Open Source version of  MS VS Studio Code
* [mpv](https://mpv.io) - Player audio/video.
* [zathura](https://pwmt.org/projects/zathura/) - Pdf document viewer
* [gdb](https://www.sourceware.org/gdb/) - Debug programs for Linux
* [vivaldi](https://vivaldi.com) - Web Browser
* [thunderbird](https://www.thunderbird.net/) - Email client
* [bat](https://github.com/sharkdp/bat) - like cat but with colors
* [lsd](https://github.com/lsd-rs/lsd) - like ls but more control with colors
* ... Some stuff here, will put when i have time
* [obs-studio](https://obsproject.com) - Open Brodcast Software
* [qemu-full](https://www.qemu.org) - For full Virtualization (with service start by sockts)
* [cups](https://openprinting.github.io/cups/) - For printing (with service start by sockts)
* [system-config-printer](https://github.com/OpenPrinting/system-config-printer) - GUI for printing configuration
* [libreoffice-fresh](https://www.libreoffice.org) - Office suit for Linux
* [Festival](http://festvox.org/festival/) - For Robotic (as I like) TTS
* [Ollama](https://ollama.com) - For my personal AI 
* [docker](https://www.docker.com) - For managing containers (with service start by sockts)
* [flatpak](https://flatpak.org) - Generic distribute aplications to the entire Linux desktop

## Keys that I use in DWM
MODKEY - > Windows Key
ShiftMask - > ShiftKey
### First key line
* MODKEY q -> Close program
* MODKEY | ShiftMask q -> log out
* MODKEY w -> Open Browser
* MODKEY e -> Open Email
* MODKEY | ShiftMask w -> Open Network Manager (nmtui)
* MODKEY r -> Open Htop
### Second key line
* MODKEY a -> Togle Gaps
* MODKEY | ShiftMask a -> Defeult Gaps
* MODKEY s -> Toggle sticky Windows (when stiky is on windows is visible in all workspaces)
* MODKEY d -> Start Menu (I use Rofi)
* MODKEY f -> togle window view to full screen
* MODKEY | ShiftMask f -> No layout Floating window
* MODKEY h -> Change Windows size left
* MODKEY j -> Change Windows focus left
* MODKEY | ShiftMask j -> Change Windows position left
* MODKEY k -> Change Windows focus right
* MODKEY | ShiftMask k -> Change Windows position right
* MODKEY l -> Change Windows size right
* MODKEY | ShiftMask r -> Open Network Manager (nmtui)
### Third key line
* MODKEY z -> increase windows gaps
* MODKEY x -> decrease windows gaps
* MODKEY b -> togle view of the taskbar
* MODKEY Minus -> Volume -5%
* MODKEY | SiftMask Minus -> Volume -15%
* MODKEY Plus -> Volume +5%
* MODKEY | SiftMask Plus -> Volume +15%
### Special keys
* MODKEY Prt sc -> Print All Screen to a file in Imagens
* MODKEY | ShiftMask Prt sc -> Print Selected Screen to a file Imagens
