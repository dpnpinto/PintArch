#!/bin/ sh
pacman -Sy git glibc
git clone https://github.com/dpnpinto/PintArch
cd $HOME/PintArch
bash PintArch.sh
