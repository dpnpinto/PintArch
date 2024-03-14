#!/usr/bin/env bash
#github-action genshdoc
#
# @file Setup
# @brief Configures installed system, installs base packages, and creates user.

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


echo -ne "
-------------------------------------------------------------------------
    ____  _       _      _             _
   |  _ \(_)_ __ | |_   / \   _ __ ___| |__
   | |_) | | '_ \| __| / _ \ | '__/ __| '_ \ NOVO
   |  __/| | | | | |_ / ___ \| | | (__| | | |
   |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|

-------------------------------------------------------------------------
                    PintArch Instalador Arch Linux
                        SCRIPTHOME: PintArch
-------------------------------------------------------------------------
"
source $HOME/PintArch/configs/setup.conf
counter
echo -ne "
-------------------------------------------------------------------------
             A instalar e verificar o GRUB BIOS Bootloader
-------------------------------------------------------------------------
"
if [[ ! -d "/sys/firmware/efi" ]]; then
    pacman -S --noconfirm grub
    grub-install --target=i386-pc --recheck ${DISK} # install GRUB in disk
    grub-mkconfig -o /boot/grub/grub.cfg #generate GRUB config
else
    pacman -S --noconfirm grub efibootmgr # for efi you have to install efibootmgr
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck # install grub to EFI partition
    grub-mkconfig -o /boot/grub/grub.cfg  #generate GRUB config
fi
counter
echo -ne "
-------------------------------------------------------------------------
                        Configuração de rede 
-------------------------------------------------------------------------
"
pacman -S --noconfirm --needed networkmanager # se for necessário dhclient
systemctl enable --now NetworkManager # activate networkmanager it is the one i like to manage network

counter
echo -ne "
-------------------------------------------------------------------------
           A atualizar os mirrors $iso para rapidos downloads
-------------------------------------------------------------------------
"
pacman -S --noconfirm --needed pacman-contrib curl # Install pacman scripts and curl (copy url)
pacman -S --noconfirm --needed reflector rsync arch-install-scripts git # Install rsync, reflector, arch install scripts amd git
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak #backup of the mirrors
reflector -a 48 -c $iso -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist # update mirror list for PT
mkdir /mnt &>/dev/null # Hiding error message if any

counter
nc=$(grep -c ^processor /proc/cpuinfo)
echo -ne "
-------------------------------------------------------------------------
                    Tens " $nc" cores.
			mudar a  makeflags para "$nc" cores. bem como
				mudar as configurações de compressão.
-------------------------------------------------------------------------
"
TOTAL_MEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTAL_MEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi

counter
echo -ne "
-------------------------------------------------------------------------
 	Definir a linguagem como PT, se és Dámérica muda :D
-------------------------------------------------------------------------
"
sed -i 's/^#pt_PT.UTF-8 UTF-8/pt_PT.UTF-8 UTF-8/' /etc/locale.gen # remove the coment from line pt_PT.UTF-8 UTF-8
locale-gen # generate local

timedatectl --no-ask-password set-timezone ${TIMEZONE} # set my time zone
timedatectl --no-ask-password set-ntp -1 # set azores time ;)
timedatectl set-ntp true # sincronize stuff

# Set keymaps
echo KEYMAP=pt-latin1 >> /etc/vconsole.conf 
# Set Laguage
echo LANG=pt_PT.UTF-8 >> /etc/locale.conf
ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc #sicronize
date # check
counter

echo -ne "
-------------------------------------------------------------------------
                    Instalação do Sistema Base 
-------------------------------------------------------------------------
"

# Add sudo for  wheel users
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

#Add parallel downloading, verbose and some nice candy
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/^#Color/Color \nILoveCandy/' /etc/pacman.conf
sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf # remove coment from multilib
pacman -Sy --noconfirm --needed # udpate now with multilib

# sed $INSTALL_TYPE is using install type to check for MINIMAL installation, if it's true, stop
# stop the script and move on, not installing any more packages below that line

if [[ ! $DESKTOP_ENV == server ]]; then
  sed -n '/'$INSTALL_TYPE'/q;p' $HOME/PintArch/pkg-files/pacman-pkgs.txt | while read line
  do
    if [[ ${line} == '--END OF MINIMAL INSTALL--' ]]; then
      # If selected installation type is FULL, skip the --END OF THE MINIMAL INSTALLATION-- line
      continue
    fi
    echo "INSTALLING: ${line}"
    sudo pacman -S --noconfirm --needed ${line}
  done
fi
echo -ne "
-------------------------------------------------------------------------
                    Instalação do Microcode AMD/Intel
-------------------------------------------------------------------------
"
# determine processor type and install microcode
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    echo "Tens um Intel - a instalar o microcode da Intel"
    pacman -S --noconfirm --needed intel-ucode
    proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    echo "Tens um AMD - A installing AMD microcode"
    pacman -S --noconfirm --needed amd-ucode
    proc_ucode=amd-ucode.img
fi

echo -ne "
-------------------------------------------------------------------------
                Instalação dos drivers da grafica
-------------------------------------------------------------------------
"
# Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    pacman -S --noconfirm --needed nvidia
	nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    pacman -S --noconfirm --needed xf86-video-amdgpu
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
    pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
fi
#SETUP IS WRONG THIS IS RUN
if ! source $HOME/PintArch/configs/setup.conf; then
	# Loop through user input until the user gives a valid username
	while true
	do 
		read -p "Please enter username:" username
		# username regex per response here https://unix.stackexchange.com/questions/157426/what-is-the-regex-to-validate-linux-users
		# lowercase the username to test regex
		if [[ "${username,,}" =~ ^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$ ]]
		then 
			break
		fi 
		echo "Incorrect username."
	done 
# convert name to lowercase before saving to setup.conf
echo "username=${username,,}" >> ${HOME}/PintArch/configs/setup.conf

    #Set Password
    read -p "Please enter password:" password
echo "password=${password,,}" >> ${HOME}/PintArch/configs/setup.conf

    # Loop through user input until the user gives a valid hostname, but allow the user to force save 
	while true
	do 
		read -p "Please name your machine:" name_of_machine
		# hostname regex (!!couldn't find spec for computer name!!)
		if [[ "${name_of_machine,,}" =~ ^[a-z][a-z0-9_.-]{0,62}[a-z0-9]$ ]]
		then 
			break 
		fi 
		# if validation fails allow the user to force saving of the hostname
		read -p "Hostname doesn't seem correct. Do you still want to save it? (y/n)" force 
		if [[ "${force,,}" = "y" ]]
		then 
			break 
		fi 
	done 

    echo "NAME_OF_MACHINE=${name_of_machine,,}" >> ${HOME}/PintArch/configs/setup.conf
fi
echo -ne "
-------------------------------------------------------------------------
                    Adicionar  o Utilizador
-------------------------------------------------------------------------
"
if [ $(whoami) = "root"  ]; then
    groupadd libvirt
    useradd -m -G wheel,libvirt -s /bin/bash $USERNAME 
    echo "$USERNAME criado, diretorio home criado, adicionado ao grupo wheel e libvirt, o shell por defeito colocado /bin/bash"

# use chpasswd to enter $USERNAME:$password
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "$USERNAME password set"

	cp -R $HOME/PintArch /home/$USERNAME/
    chown -R $USERNAME: /home/$USERNAME/PintArch
    echo "PintArch copiado para o diretorio home"

# enter $NAME_OF_MACHINE to /etc/hostname
	echo $NAME_OF_MACHINE > /etc/hostname
else
	echo "You are already a user proceed with aur installs"
fi
if [[ ${FS} == "luks" ]]; then
# Making sure to edit mkinitcpio conf if luks is selected
# add encrypt in mkinitcpio.conf before filesystems in hooks
    sed -i 's/filesystems/encrypt filesystems/g' /etc/mkinitcpio.conf
# making mkinitcpio with linux kernel
    mkinitcpio -p linux
fi
echo -ne "
-------------------------------------------------------------------------
                    SISTEMA PRONTO PARA 2-user.sh
-------------------------------------------------------------------------
"
