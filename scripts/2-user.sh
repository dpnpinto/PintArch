#!/usr/bin/env bash
# github-action genshdoc
#
# @file User
# @brief User customizations and AUR package installation.

echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \ NOVO
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

-------------------------------------------------------------------------
                    Instalação do Arch Linux
                      Script: PintArch
-------------------------------------------------------------------------

Installing AUR Softwares
"
source $HOME/PintArch/configs/setup.conf

cd ~

sed -n '/'$INSTALL_TYPE'/q;p' ~/PintArch/pkg-files/${DESKTOP_ENV}.txt | while read line
do
  if [[ ${line} == '--END OF MINIMA INSTALL--' ]]
  then
    # If selected installation type is FULL, skip the --END OF THE MINIMAL INSTALLATION-- line
    continue
  fi
  echo "A Instalar: ${line}"
  sudo pacman -S --noconfirm --needed ${line}
done

# if you need aur I don't
if [[ ! $AUR_HELPER == none ]]; then
  cd ~
  git clone "https://aur.archlinux.org/$AUR_HELPER.git"
  cd ~/$AUR_HELPER
  makepkg -si --noconfirm
  # sed $INSTALL_TYPE is using install type to check for MINIMAL installation, if it's true, stop
  # stop the script and move on, not installing any more packages below that line
  sed -n '/'$INSTALL_TYPE'/q;p' ~/ArchTitus/pkg-files/aur-pkgs.txt | while read line
  do
    if [[ ${line} == '--END OF MINIMAL INSTALL--' ]]; then
      # If selected installation type is FULL, skip the --END OF THE MINIMAL INSTALLATION-- line
      continue
    fi
    echo "INSTALLING: ${line}"
    $AUR_HELPER -S --noconfirm --needed ${line}
  done
fi

export PATH=$PATH:~/.local/bin

echo $DESKTOP_ENV
echo $DESKTOP_ENV
# Lets install My DWM
if [[ $DESKTOP_ENV == "DWM" ]]; then
   # to my dwm full install and startup
  echo -ne "
  -------------------------------------------------------------------------
                    THE NEW STUFF
  -------------------------------------------------------------------------
  "

   echo "Clone Pinto Stuff"
   git clone https://github.com/dpnpinto/PintoDWM /home/$USERNAME/.config
   git clone https://github.com/dpnpinto/PintoST /home/$USERNAME/.config
   git clone https://github.com/dpnpinto/PintoDWMBLOCKS /home/$USERNAME/.config
   cd /home/$USERNAME/.config/PintoDWM
   make install
   cd /home/$USERNAME/.config/PintoST
   make install
   cd /home/$USERNAME/.config/PintoDWMBlocks
   make install
   cp -r /home/$USERNAME/PintArch/configs/start_confs/*  /home/$USERNAME/
   mkdir /home/$USERNAME/.config/scrips
   cp -r /home/$USERNAME/.config/PintoDWMBlocks/scrips/*  /home/$USERNAME/
   chown -R $USERNAME: /home/$USERNAME/.config
   chmod 755 /home/$USERNAME/.config/scripts/*   
fi

# Theming DE if user chose FULL installation
if [[ $INSTALL_TYPE == "TOTAL" ]]; then
  if [[ $DESKTOP_ENV == "DWM" ]]; then
   # to my dwm full install if i whant to do something else
  fi
fi

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
