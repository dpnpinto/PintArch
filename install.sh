#!/bin/ sh
pacman -Sy --noconfirm git
git clone https://github.com/dpnpinto/PintArch
cd $HOME/PintArch
bash PintArch.sh
