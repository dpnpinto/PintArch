#!/bin/ sh
# Pinto Arch Linux (PintArch) Ĩnstall
# dpnpinto@gmail.com
# Installing git
pacman -Sy --noconfirm --needed git glibc
git clone https://github.com/dpnpinto/PintArch
echo "Executar o script de Instalação"
cd $HOME/PintArch
bash PintArch.sh
