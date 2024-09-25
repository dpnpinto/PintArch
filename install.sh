#!/bin/ sh
pacman -Sy --noconfirm git glibc
git clone https://github.com/dpnpinto/PintArch
cd $HOME/PintArch
bash PintArch.sh
