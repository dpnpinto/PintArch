#!/bin/ sh -e
pacman -Sy --noconfirm --needed git glibc
git clone https://github.com/dpnpinto/PintArch
cd $HOME/PintArch
bash PintArch.sh
