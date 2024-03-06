#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  ____  _       _      _             _
# |  _ \(_)_ __ | |_   / \   _ __ ___| |__
# | |_) | | '_ \| __| / _ \ | '__/ __| '_ \
# |  __/| | | | | |_ / ___ \| | | (__| | | |
# |_|   |_|_| |_|\__/_/   \_|_|  \___|_| |_|
#
#-------------------------------------------------------------------------
#github-action genshdoc
#
# @file Preinstall
# @brief Contains the steps necessary to configure and pacstrap the install to selected drive. 

# Counter function
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


# start this preinstalation bash script with the counter
counter
echo -ne "
-------------------------------------------------------------------------
             Seleciona os mirrors para download's otimizados          
-------------------------------------------------------------------------
"
source $CONFIGS_DIR/setup.conf
iso=$(curl -4 ifconfig.co/country-iso) # Set local based of network location
timedatectl set-ntp true # set ntp to true to sincronize clock and date
pacman -Sy # updadte repo
pacman -S --noconfirm archlinux-keyring # update keyrings to latest to prevent packages failing to install
pacman -S --noconfirm --needed pacman-contrib terminus-font # Install extra scripts for pacman and terminus font
setfont ter-v22b # set the font to ter-v22b setfont [-m MAPPING] ter-<X><SIZE><STYLE>]
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf # edit pacman.conf and set ParallelDownloads
pacman -S --noconfirm --needed reflector rsync grub # install reflector rsync amd grub
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup # backup of the mirrorlist
counter
echo -ne "
-------------------------------------------------------------------------
           A atualizar os mirrors $iso para rapidos downloads
-------------------------------------------------------------------------
"
reflector -a 48 -c $iso -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist # update mirror list for PT
mkdir /mnt &>/dev/null # Hiding error message if any

counter
echo -ne "
-------------------------------------------------------------------------
                      A Instalar prerequesitos
-------------------------------------------------------------------------
"
pacman -S --noconfirm --needed gptfdisk  glibc #gpt partition, btfs (only install is btfs is selected btrfs-progs) filesystem and Gnu lib C
counter
echo -ne "
-------------------------------------------------------------------------
                  Criar as pasrtições para o disco e formatar
-------------------------------------------------------------------------
"
umount -A --recursive /mnt # make sure everything is unmounted before we start
# disk partition
sgdisk -Z ${DISK} # zap all GPT/MBR on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment, no MBR here bro

# create partitions

if [[ ! -d "/sys/firmware/efi" ]]; then # BIOS BOOT
sgdisk -n 1::+1G --typecode=1:ef02 --change-name=1:'BIOS boot partition' ${DISK} # partition 1 (BIOS Boot Partition)
else # UEFI BOOT
sgdisk -n 1::+1G --typecode=1:ef00 --change-name=1:'EFI System' ${DISK} # partition 1 (UEFI Boot Partition)
fi
sgdisk -n 2::+4G --typecode=2:8200 --change-name=2:'Linux swap' ${DISK} # partition 2 SWAP partition
sgdisk -n 3::-0 --typecode=3:8300 --change-name=3:'Linux filesystem' ${DISK} # partition 3 (Root), default start, remaining



partprobe ${DISK} # reread partition table to ensure it is correct
lsblk ${DISK} # Show what we have done
counter
# make filesystems
echo -ne "
-------------------------------------------------------------------------
                    A criar sistema de ficheiros
-------------------------------------------------------------------------
"
# @description Creates the btrfs subvolumes. 
createsubvolumes () {
    btrfs subvolume create /mnt/@
    btrfs subvolume create /mnt/@home
    btrfs subvolume create /mnt/@var
    btrfs subvolume create /mnt/@tmp
    btrfs subvolume create /mnt/@.snapshots
}

# @description Mount all btrfs subvolumes after root has been mounted.
mountallsubvol () {
    mount -o ${MOUNT_OPTIONS},subvol=@home ${partition3} /mnt/home
    mount -o ${MOUNT_OPTIONS},subvol=@tmp ${partition3} /mnt/tmp
    mount -o ${MOUNT_OPTIONS},subvol=@var ${partition3} /mnt/var
    mount -o ${MOUNT_OPTIONS},subvol=@.snapshots ${partition3} /mnt/.snapshots
}

# @description BTRFS subvolulme creation and mounting. 
subvolumesetup () {
# create nonroot subvolumes
    createsubvolumes     
# unmount root to remount with subvolume 
    umount /mnt
# mount @ subvolume
    mount -o ${MOUNT_OPTIONS},subvol=@ ${partition3} /mnt
# make directories home, .snapshots, var, tmp
    mkdir -p /mnt/{home,var,tmp,.snapshots}
# mount subvolumes
    mountallsubvol
}

if [[ "${DISK}" =~ "nvme" ]]; then
    partition1=${DISK}p1
    partition2=${DISK}p2
    partition3=${DISK}p3
else
    partition1=${DISK}1
    partition2=${DISK}2
    partition3=${DISK}3
fi

# Main system format and mount

if [[ "${FS}" == "btrfs" ]]; then
    mkfs.btrfs -L ROOT ${partition3} -f
    mount -t btrfs ${partition3} /mnt
    subvolumesetup
elif [[ "${FS}" == "ext4" ]]; then
    mkfs.ext4 -L ROOT ${partition3}
    mount -t ext4 ${partition3} /mnt
elif [[ "${FS}" == "luks" ]]; then
# enter luks password to cryptsetup and format root partition
    echo -n "${LUKS_PASSWORD}" | cryptsetup -y -v luksFormat ${partition3} -
# open luks container and ROOT will be place holder 
    echo -n "${LUKS_PASSWORD}" | cryptsetup open ${partition3} ROOT -
# now format that container
    mkfs.btrfs -L ROOT ${partition3}
# create subvolumes for btrfs
    mount -t btrfs ${partition3} /mnt
    subvolumesetup
# store uuid of encrypted partition for grub
    echo ENCRYPTED_PARTITION_UUID=$(blkid -s UUID -o value ${partition3}) >> $CONFIGS_DIR/setup.conf
fi

# Boot partition format and mount

mkdir -p /mnt/home # create home directory
mkdir -p /mnt/boot # cretae boot directory
if [[ ! -d "/sys/firmware/efi" ]]; then # BIOS BOOT
    mkfs.vfat -F32 -n "BIOSBOOT" ${partition1}
else # UEFI BOOT
    mkfs.vfat -F32 -n "EFIBOOT" ${partition1}
    mkdir -p /mnt/boot/efi # make efi dir for EFI
    mount -t ${partition1} /mnt/boot/efi # mount partition for EFI
fi

# swap activation
mkswap ${partition2}
swapon ${partition2}

if ! grep -qs '/mnt' /proc/mounts; then
    echo "Drive is not mounted can not continue"
    echo "Rebooting in 3 Seconds ..." && sleep 1
    echo "Rebooting in 2 Seconds ..." && sleep 1
    echo "Rebooting in 1 Second ..." && sleep 1
    reboot now
fi
lsblk ${DISK} 
counter
counter
echo -ne "
-------------------------------------------------------------------------
            A instalar o Arch Linux na drive principal
-------------------------------------------------------------------------
"
pacstrap /mnt base base-devel linux linux-firmware vim sudo archlinux-keyring wget libnewt --noconfirm --needed
echo "keyserver hkp://keyserver.ubuntu.com" >> /mnt/etc/pacman.d/gnupg/gpg.conf
cp -R ${SCRIPT_DIR} /mnt/root/PintArch
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

genfstab -L /mnt >> /mnt/etc/fstab
echo " 
  Tabela de file system criada /etc/fstab:
"
cat /mnt/etc/fstab

counter
echo -ne "
-------------------------------------------------------------------------
             A instalar e verificar o GRUB BIOS Bootloader
-------------------------------------------------------------------------
"
if [[ ! -d "/sys/firmware/efi" ]]; then
    grub-install --boot-directory=/mnt/boot ${DISK}
else
    pacstrap /mnt efibootmgr --noconfirm --needed
fi

counter
echo -ne "
-------------------------------------------------------------------------
             A verificar se o sistema tem menos de 8 Gbytes
-------------------------------------------------------------------------
"
TOTAL_MEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTAL_MEM -lt 8000000 ]]; then
    # Put swap into the actual system, not into RAM disk, otherwise there is no point in it, it'll cache RAM into RAM. So, /mnt/ everything.
    mkdir -p /mnt/opt/swap # make a dir that we can apply NOCOW to to make it btrfs-friendly.
    chattr +C /mnt/opt/swap # apply NOCOW, btrfs needs that.
    dd if=/dev/zero of=/mnt/opt/swap/swapfile bs=1M count=2048 status=progress
    chmod 600 /mnt/opt/swap/swapfile # set permissions.
    chown root /mnt/opt/swap/swapfile
    mkswap /mnt/opt/swap/swapfile
    swapon /mnt/opt/swap/swapfile
    # The line below is written to /mnt/ but doesn't contain /mnt/, since it's just / for the system itself.
    echo "/opt/swap/swapfile	none	swap	sw	0	0" >> /mnt/etc/fstab # Add swap to fstab, so it KEEPS working after installation.
fi

counter
echo -ne "
-------------------------------------------------------------------------
                    SISTEMA PREPARADO para o 1-setup.sh
-------------------------------------------------------------------------
"
