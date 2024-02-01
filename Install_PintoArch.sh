# Pinto Arch Linux (PintArch) Ĩnstall
#dpnpinto@gmail.com
# Installing git

echo "Instalar o git."
pacman -Sy --noconfirm --needed git glibc

echo "Clonar o projeto PintArch"

git clone https://github.com/christitustech/ArchTitus

echo "Executar o script de Instalação"

cd $HOME/PintoArch

exec ./PintArch.sh
