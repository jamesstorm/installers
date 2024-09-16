#/bin/bash

# Install more things

pacman -S alsa-utils arch-install-scripts archinstall bind bolt brltty btrfs-progs clonezilla \
  cryptsetup darkhttpd ddrescue dhclient dhcpcd diffutils dmidecode dmraid dnsmasq \
  dosfstools e2fsprogs edk2-shell espeakup ethtool exfatprogs f2fs-tools fatresize \
  fsarchiver gnu-netcat gpart gpm gptfdisk grml-zsh-config hdparm hyperv intel-ucode \
  irssi iw jfsutils kitty-terminfo less lftp libfido2 libusb-compat linux-atm \
  linux-firmware-marvell livecd-sounds lsscsi lvm2 lynx man-db man-pages mc mdadm \
  memtest86+ mkinitcpio mkinitcpio-archiso mkinitcpio-nfs-utils modemmanager mtools \
  nano nbd ndisc6 nfs-utils nilfs-utils nmap ntfs-3g nvme-cli open-iscsi open-vm-tools \
  openconnect openssh openvpn partclone parted partimage pcsclite ppp pptpclient pv \
  python-requests qemu-guest-agent refind reflector reiserfsprogs rp-pppoe rsync \
  rxvt-unicode-terminfo screen sdparm sg3_utils smartmontools sof-firmware squashfs-tools \
  sudo syslinux systemd-resolvconf t2strap tcpdump terminus-font testdisk tmux tpm2-tss \
  udftools usb_modeswitch usbmuxd usbutils vim virtualbox-guest-utils-nox vpnc \
  wireless-regdb wireless_tools wpa_supplicant wvdial xfsprogs xl2tpd zsh neovim \
  stow unzip openssh git

# creat swapfile and add to fstab

pacman -S neovim stow git openssh
btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile
swapon /swap/swapfile

echo "" >>/etc/fstab
echo "/swap/swapfile none swap defaults 0 0" >>/etc/fstab

# set time zone and hwclock

ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime
hwclock --systohc

# Generate the locales
sed -i 's/#en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen
echo "LANG=en_CS.UTF-8" >>/etc/locale.conf
locale-gen

# Hostname
echo "march" >>/etc/hostname

# Hosts file
cp hosts /etc/hosts

# User and Root password

echo -e "james\njames" | passwd
useradd -rm -d /home/james -s /bin/zsh -u 1000 -g 1000 -G sudo -p "$(openssl passwd -1 james)" james
echo "james ALL=(ALL:ALL) ALL" >>/etc/sudoers

# Apple T2 chip thingy
sed -i 's/Modules=()/Modules=(apple-bce)/' /etc/mkinitcpio.conf
mkinitcpio -P

#enable some services

systemctl enable ModemManager.service
systemctl enable bolt.service
systemctl enable dbus-broker.service
systemctl enable dhcpcd.service
systemctl enable getty@tty1.service
systemctl enable iwd.service
systemctl enable polkit.service
systemctl enable sshd.service
systemctl enable systemd-homed.service
systemctl enable systemd-journald.service
systemctl enable systemd-logind.service
systemctl enable systemd-networkd.service
systemctl enable systemd-nsresourced.service
systemctl enable systemd-resolved.service
systemctl enable systemd-timesyncd.service
systemctl enable systemd-udevd.service
systemctl enable systemd-userdbd.service
systemctl enable t2fanrd.service
systemctl enable tiny-dfr.service # this may fail
systemctl enable user@0.service .service

# to make sure DNS works right
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# grub things
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="quiet splash intel_iommu=on iommu=pt pcie_ports=compat"/g' /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="quiet splash intel_iommu=on iommu=pt pcie_ports=compat"/g' /etc/default/grub
echo "DONE!!!! exit and reboot"
