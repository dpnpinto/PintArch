#!/bin/ sh
pacman -Sy git glibc
url = "<https://github.com/dpnpinto/PintArch>"
git clone --noconfirm url
cd $HOME/PintArch
bash PintArch.sh
