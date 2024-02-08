#!/bin/bash
#
# PintArch
#-------------------------------------------------------------------------
#  ____  _       _      _             _
# |  _ \(_)_ __ | |_   / \   _ __ ___| |__
# | |_) | | '_ \| __| / _ \ | '__/ __| '_ \
# |  __/| | | | | |_ / ___ \| | | (__| | | |
# |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|
#
#-------------------------------------------------------------------------
# Initial Script that start the scripts for each stages of instalation

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
echo -ne "
-------------------------------------------------------------------------
                    Diretorios do PintArch automatizado
-------------------------------------------------------------------------
"
echo $SCRIPT_DIR
echo $SCRIPTS_DIR
echo $CONFIGS_DIR
echo -ne "
-------------------------------------------------------------------------
"
set +a
echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

-------------------------------------------------------------------------
                    Instalação do PintArch automatizada
-------------------------------------------------------------------------
             Os scripts estão no diretório chamado PintArch
"
#    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
#      source $CONFIGS_DIR/setup.conf
#    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
#    ( arch-chroot /mnt $HOME/ArchTitus/scripts/1-setup.sh )|& tee 1-setup.log
#    if [[ ! $DESKTOP_ENV == server ]]; then
#      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/ArchTitus/scripts/2-user.sh )|& tee 2-user.log
#    fi
#    ( arch-chroot /mnt $HOME/ArchTitus/scripts/3-post-setup.sh )|& tee 3-post-setup.log
#    cp -v *.log /mnt/home/$USERNAME

echo -ne "
-------------------------------------------------------------------------
   PintaArch
-------------------------------------------------------------------------
              Intalação do PintaARch Automatizada Concluida
-------------------------------------------------------------------------
          Por favor retirar o dispositivo de arranque e reiniciar 
"
