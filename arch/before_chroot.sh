#/bin/bash

INSTALL_PARTITION=/dev/nvme0n1p3
BOOT_PARTITION=/dev/nvme0n1p1

# Connect to wifi
#

iwctl station wlan0 connect Stormnet --passphrase "WonderMagicEquinox"
iwctl station wlan0 show

# time and date
timdatectl set-ntp true

# set pacman mirrorlist
pacman -Sy reflector
reflector -c Canada -a 6 --sort rate --save /etc/pacman.d/mirrorlist

# partition
echo "#####"
echo "Partitioning $INSTALL_PARTITION"
echo "select n, defaults."
echo "select w, Y to write the changes"
gdisk $INSTALL_PARTITION

# formatting
echo "Formatting $INSTALL_PARTITION"
mkfs.btrfs -f -L Arch $INSTALL_PARTITION

# mount the partitions
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

# Install base packages

# this is the list from the t2archiso
pacstrap /mnt alsa-utils apple-t2-audio-config apple-bcm-firmware arch-install-scripts archinstall base bind bolt brltty btrfs-progs clonezilla cryptsetup darkhttpd ddrescue dhclient dhcpcd diffutils dmidecode dmraid dnsmasq dosfstools e2fsprogs edk2-shell efibootmgr espeakup ethtool exfatprogs f2fs-tools fatresize fsarchiver gnu-netcat gpart gpm gptfdisk grml-zsh-config grub hdparm hyperv intel-ucode irssi iw iwd jfsutils kitty-terminfo less lftp libfido2 libusb-compat linux-t2 linux-atm linux-firmware linux-firmware-marvell livecd-sounds lsscsi lvm2 lynx man-db man-pages mc mdadm memtest86+ mkinitcpio mkinitcpio-archiso mkinitcpio-nfs-utils modemmanager mtools nano nbd ndisc6 nfs-utils nilfs-utils nmap ntfs-3g nvme-cli open-iscsi open-vm-tools openconnect openssh openvpn partclone parted partimage pcsclite ppp pptpclient pv python-requests qemu-guest-agent refind reflector reiserfsprogs rp-pppoe rsync rxvt-unicode-terminfo screen sdparm sg3_utils smartmontools sof-firmware squashfs-tools sudo syslinux systemd-resolvconf t2fanrd t2strap tcpdump terminus-font testdisk tiny-dfr tmux tpm2-tss udftools usb_modeswitch usbmuxd usbutils vim virtualbox-guest-utils-nox vpnc wireless-regdb wireless_tools wpa_supplicant wvdial xfsprogs xl2tpd zsh
#my additions
pacstrap /mnt neovim stow git linux-t2 linux-t2-headers unzip openssh

# generate the fstab
genfstab -U /mnt >>/mnt/etc/fstab

echo "#####"
echo "DONE - now run arch-chroot /mnt"
