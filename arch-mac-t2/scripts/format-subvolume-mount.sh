#/bin/bash

source ../config.sh

<<<<<<< HEAD:arch-mac-t2/scripts/format-subvolume-mount.sh
=======
# Need to be connected to wifi before this runs
#

iwctl station wlan0 show

# time and date
timdatectl set-ntp true

# set pacman mirrorlist
pacman -Sy --noconfirm reflector
reflector -c Canada -a 6 --sort rate --save /etc/pacman.d/mirrorlist

# partition
echo "#####"
echo "Partitioning $INSTALL_PARTITION"
echo "select n, defaults."
echo "select w, Y to write the changes"
gdisk $INSTALL_PARTITION

# formatting
>>>>>>> 42dabab6916ff8f4db569827c1664370d885827a:arch/before_chroot.sh
echo "Formatting $INSTALL_PARTITION"
mkfs.btrfs -f -L Arch $INSTALL_PARTITION

mount $INSTALL_PARTITION /mnt
mount --mkdir $BOOT_PARTITION /mnt/boot

# create subvolumes
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@swap
btrfs subvolume create /mnt/@.snapshots

umount /mnt/boot
umount /mnt

mount -o noatime,compress=lzo,space_cache,subvol=@root $INSTALL_PARTITION /mnt
mount --mkdir -o noatime,compress=lzo,subvol=@home $INSTALL_PARTITION /mnt/home
mount --mkdir -o noatime,compress=lzo,subvol=@srv $INSTALL_PARTITION /mnt/srv
mount --mkdir -o noatime,compress=lzo,subvol=@tmp $INSTALL_PARTITION /mnt/tmp
mount --mkdir -o noatime,compress=lzo,subvol=@opt $INSTALL_PARTITION /mnt/opt
mount --mkdir -o noatime,compress=lzo,subvol=@.snapshots $INSTALL_PARTITION /mnt/.snapshots
mount --mkdir -o nodatacow,subvol=@swap $INSTALL_PARTITION /mnt/swap
mount --mkdir -o nodatacow,subvol=@var $INSTALL_PARTITION /mnt/var
mount --mkdir $BOOT_PARTITION /mnt/boot
