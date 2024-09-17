#/bin/bash

source ../config.sh

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
