# [PintArch](https://github.com/dpnpinto/PintArch/) - My personal instalation of [Arch Linux](https://archlinux.org)
-------------------------------------------------------------------------
#                      By **https://dpnpinto.github.io**
-------------------------------------------------------------------------
# **[PintArch](https://github.com/dpnpinto/PintArch/) - Ain't got no teeth, ain't got cavities.**
From the start of an Arch image, get it here [https://archlinux.org/download/](https://archlinux.org/download/)
- To install just use:
  * **curl -LO https://raw.githubusercontent.com/dpnpinto/PintArch/main/install.sh**
  * **bash install.sh**
- Or just do it yourself:
  * **loakeys pt-latint1**
  * **pacman -Sy git**
  * **git clone https://github.com/dpnpinto/PintArch**, the instalation script is the BASH file **PintArch.sh** 
- Remember that this is made by me to me, use at your own risk, allways changing something here.
- However remember that it is very useful to perform a manual installation, you can follow the [Arch Wiki](https://wiki.archlinux.org/title/Installation_guide) or my resume in Portuguese  [here](https://github.com/dpnpinto/PintArch/blob/main/Install_arch_notes.md)
-------------------------------------------------------------------------
# **[PintArch](https://github.com/dpnpinto/PintArch/)** - What I need and deserve
-------------------------------------------------------------------------
## I designed this version of PintArch but, in reality, it is the simplified installation, using [BASH](https://www.gnu.org/software/bash/), of my [Arch Linux](https://archlinux.org).
## It is not a pure Linux version on top of the [kernel](https://kernel.org), but, with the same mentality as [Linus Torvalds](https://github.com/torvalds/linux), I needed a version of an operating system for my [Workstation](https://en.wikipedia.org/wiki/Workstation) that met my needs to be light, simple, secure, and flexible.
## As a 'purist' I prefer [base distributions](https://en.wikipedia.org/wiki/List_of_Linux_distributions) rather than the ones 'based on'. I've tested a lot of them just to see how they work, for several reasons, they have been set aside.
## In my opinion, and what I aim for is, an operating system that is secure and has the smallest footprint possible, meaning it has the minimal impact on the equipment so that processing is, for the most part, efficiently used by the processes and applications the user is running.
## The [Arch Linux](https://archlinux.org) distribution is perfect for this. It is one of the best Linux distributions for desktop use, and for what I need, because::

* It is very (allways) up-to-date distribution ([Rolling Release](https://en.wikipedia.org/wiki/Rolling_release))
* It has a large community of very dedicated people https://gitlab.archlinux.org/archlinux
* It allows me to install everything I want (I don't know of any software that I can't get to work on Arch, yes even "Windows troublesoftware"
* It is completely modular and adaptable to the needs of any user
* It, always, has the latest updates https://wiki.archlinux.org/title/ArchWiki:About
* It has a very well-documented source of knowledge (Arch Wiki) https://wiki.archlinux.org
* It has the best open repository from a Linux community (AUR) https://aur.archlinux.org
--------------------------------------------------------------------------
# **[PintArch](https://github.com/dpnpinto/PintArch/)** Software packages used in this instalation of [Arch Linux](https://archlinux.org)
--------------------------------------------------------------------------

## System Level
* [grub](https://www.gnu.org/software/grub/) - Boot  loader that I use
* [base](https://archlinux.org/packages/core/any/base/) - Base Linux package for Arch Linux
* [base-devel](https://archlinux.org/packages/core/any/base-devel/) - Base developer package
* [Systemd](https://systemd.io) - Yes I like that Arch Linux use it, I use sockets in my workstation every time I can so...
* [linux](https://archlinux.org/packages/core/x86_64/linux/) - Linux kernel and modules, you can use others, RTFM.
* [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) - Firmware files
* [networkmanager](https://www.networkmanager.dev) - The only thing that you need for network management
* [pipewire](https://pipewire.org) - Get all the sound that you deserve in a computer
## System Level with GUI DWM
* [feh](https://feh.finalrewind.org/) - Image management, including background image.
* [picom](https://picom.app) - Compositor for Xorg, for example for transparency management, rounded corners, blur, etc.
* [lxappearance](https://github.com/lxde/lxappearance) - Get icons and fancy stuff management for GTK
* [qt6ct](https://github.com/trialuser02/qt6ct) - Get icons and fancy stuff management for QT
* [rofi](https://github.com/davatorium/rofi) - Use for starting aplications on the GUI
* [xorg-server](https://www.x.org/wiki/) - Yes, still using the most popular display server
* [PintoDWM](https://github.com/dpnpinto/PintoDWM) - My Dinamic Windows Management based on DWM
* [PintoST](https://github.com/dpnpinto/PintoST) - My Simple Terminal based on ST
* [PintoDWMBlocks](https://github.com/dpnpinto/PintoDWMBlocks) - My task bar based on DWMBlocks
## At user level
* [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) - Manage "well known" user directories like the desktop folder and the music folder. It also handles localization (i.e. translation) of the filenames
* [maim](https://github.com/naelstrof/maim) - Make image the software that I use for screenshot 
* [vim](https://www.vim.org) - The best editor
* [pcmanfm](https://github.com/lxqt/pcmanfm-qt) - GUI file manager that I like, configure terminal (st %s), and dont forget the gvfs (RTFM)
* [yazi](https://github.com/sxyazi/yazi) - Terminal file manager
* [ueberzugpp](https://github.com/jstkdng/ueberzugpp) - To get image view in terminal (ueberzu in fast cpp)  for yazi 
* [fzf](https://github.com/junegunn/fzf) - Fuzzy finder, for multiple use and find files
* [tree](https://gitlab.com/OldManProgrammer/unix-tree) - Everybody knows tree
* [figlet](http://www.figlet.org) - Need this ok, fancy ASCII names ;)
* [fastfetch](https://github.com/fastfetch-cli/fastfetch) - Show, in a nice format, what is your config
* [htop](https://htop.dev) e [btop](https://github.com/aristocratos/btop) - Visualize system resorces
* [nvtop](https://github.com/Syllo/nvtop) - visualize nvidia resorces (I use a Nvidia Card) 
* [code](https://github.com/microsoft/vscode) -Open Source version of  MS VS Studio Code
* [mpv](https://mpv.io) - Player audio/video.
* [zathura](https://pwmt.org/projects/zathura/) - Pdf document viewer
* [gdb](https://www.sourceware.org/gdb/) - Debug programs for Linux
* [vivaldi](https://vivaldi.com) - Web Browser that I like, with DuckDuckGo as search engine ;) (at least from a european company)
* [thunderbird](https://www.thunderbird.net/) - Email client
* [bat](https://github.com/sharkdp/bat) - like cat but with colors
* [eza](https://github.com/eza-community/eza) - like ls but more control with colors
* [dysk](https://github.com/Canop/dysk) - Like df but more human like and with color (it run like df I have an alias to it)
* [axel](https://github.com/axel-download-accelerator/axel) - Parallel downloads
* [ncdu](https://dev.yorhel.nl/ncdu) - Disk utilization (alias du)
* [tealdeer(tldr)](https://github.com/tealdeer-rs/tealdeer) - To long Don't Read (tldr) implemented in rust ;)
* [rclone](https://rclone.org) - Yes it is based in [rsync](https://github.com/rsyncproject/rsync) and is witen in go. Rsync for the cloud (it is what i like to name it)
* ... Some more details missing here, yes with Arch you can do everything, will put more details when i have time but allways RDFM.
* [obs-studio](https://obsproject.com) - Open Brodcast Software
* [kdenlive](https://kdenlive.org) - Opens Source Video editing
* [qemu-full](https://www.qemu.org) - For full Virtualization (with service start by sockts)
* [libvirt](https://libvirt.org) - Virtualization API for QEMU
* [virt-manager](https://virt-manager.org/) - GUI for Virtual Machine Management 
* [cups](https://openprinting.github.io/cups/) - For printing (with service start by sockts)
* [system-config-printer](https://github.com/OpenPrinting/system-config-printer) - GUI for printing configuration
* [calibre](https://calibre-ebook.com/) - Ebook reader
* [libreoffice-fresh](https://www.libreoffice.org) - Office suit for Linux
* [drawio-desktop](https://app.diagrams.net) - Diagrams
* [Festival](http://festvox.org/festival/) - For Robotic voice to my personal AI (as I like), nice TTS
* [Ollama](https://ollama.com) - For my personal AI 
* [docker](https://www.docker.com) - For managing containers (with service start by sockts)
* [flatpak](https://flatpak.org) - Generic distribute aplications to the entire Linux desktop
* [inxi](https://codeberg.org/smxi/inxi) - Ultimate system information tool
* [imagemagick](https://imagemagick.org) - Put some magick into images
* [mtr](https://www.bitwizard.nl/mtr/) - Ping and traceroot in one better command
* [iperf](https://github.com/esnet/iperf) - Test bandwith between sites
* [tcpdump](https://www.tcpdump.org/) - Lightweight paket capture
* [nmap](https://nmap.org/) - Scan remote ports/network
* [bind](https://www.isc.org/bind/) - DNS tools, your know like [dig](https://linux.die.net/man/1/dig) and [nslookup](https://linux.die.net/man/1/nslookup)

## Keys that I use in DWM (PintoDWM)
MODKEY - > Windows Key
ShiftMask - > ShiftKey
### General purpose
* MODKEY j/k -> Cycle thru windows by stack order
* MODKEY space -> Make the selected Window the master
* MODKEY | ShiftMask space -> Make a windows float 
* MODKEY h/l -> Change with of the master Window
* MODKEY a -> Toggle gaps
* MODKEY | ShiftMask a -> Gaps return to defaul value, can use MODKEY and midle buton
* MODKEY s -> Open GUI filemanager (using pcmanfm)
* MODKEY | ShiftMask s -> Toggle sticky Windows (when stiky is on windows is visible in all workspaces)
* MODKEY b -> togle view of the taskbar
* MODKEY v -> Jump to master Windows
### Windows Layouts

... Organizing this

* MODKEY w -> Open Browser
* MODKEY e -> Open Email
* MODKEY | ShiftMask w -> Open Network Manager (nmtui)
* MODKEY r -> Open Htop
### Second key line
* MODKEY a -> Togle Gaps
* MODKEY | ShiftMask a -> Defeult Gaps
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
* MODKEY Minus -> Volume -5%
* MODKEY | SiftMask Minus -> Volume -15%
* MODKEY Plus -> Volume +5%
* MODKEY | SiftMask Plus -> Volume +15%
### Special keys
* MODKEY Prt sc -> Print All Screen to a file in Imagens
* MODKEY | ShiftMask Prt sc -> Print Selected Screen to a file Imagens

## Keys that I use in ST (PintoST)
* ControlMask | SiftMask  j -> Zoom -1
* ControlMask | SiftMask  k -> Zoom +1
* ControlMask | SiftMask  h -> Zoom -2
* ControlMask | SiftMask  l -> Zoom +2
* ControlMask | SiftMask  r -> Zoom reset
* ControlMask | SiftMask  c -> Clipcopy
* ControlMask | SiftMask  v -> Clippast

![PintArch](https://raw.githubusercontent.com/dpnpinto/PintArch/refs/heads/main/PintArch.png)
