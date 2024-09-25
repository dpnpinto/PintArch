#!/bin/ sh
# Pinto Arch Linux (PintArch) Ĩnstall
# dpnpinto@gmail.com
# Installing git
pacman -Sy --noconfirm --needed git glibc
git clone https://github.com/dpnpinto/PintArch
cd $HOME/PintArch
bash PintArch.sh
