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

counter() {
count=10
# Count down to 0 using a C-style arithmetic expression inside `((...))`.
# Note: Increment the count first so as to simplify the `while` loop.
(( ++count )) 
echo
while (( --count >= 0 )); do
  echo -n -
  echo -n $count
  sleep 1
done
clear
echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \ NOVO
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

"
}

set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \ NOVO
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

-------------------------------------------------------------------------
                       BY https://dpnpinto.github.io
-------------------------------------------------------------------------
            Diretorios da Instalação da PintArch automatizada
-------------------------------------------------------------------------
"
echo 'Diretório da Solução->' $SCRIPT_DIR
echo 'Diretório dos Scripts->' $SCRIPTS_DIR
echo 'Diretório das Configurações->' $CONFIGS_DIR
echo -ne "
-------------------------------------------------------------------------
"
counter
set +a
echo -ne "
-------------------------------------------------------------------------
                Inicio da instalação do PintArch automatizada
-------------------------------------------------------------------------
"
    loadkeys pt-latin1 # set keybord keys to PT
    # set varibles a store in setup.conf
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
    source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
#    (arch-chroot /mnt bash $HOME/PintArch/scripts/1-setup.sh )|& tee 1-setup.log
#    if [[ ! $DESKTOP_ENV == server ]]; then
#      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/ArchTitus/scripts/2-user.sh )|& tee 2-user.log
#    fi
#    ( arch-chroot /mnt $HOME/ArchTitus/scripts/3-post-setup.sh )|& tee 3-post-setup.log
#    cp -v *.log /mnt/home/$USERNAME

echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \ NOVO
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

-------------------------------------------------------------------------
                 Fim da intalação do PintArch Automatizada
-------------------------------------------------------------------------
          Por favor retirar o dispositivo de arranque e reiniciar 
"
