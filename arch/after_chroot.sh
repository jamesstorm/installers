#/bin/bash

cd $HOME/installers/arch/

USER=james
PASSWORD=james
ROOTPASSWORD=james

source ./pacman.sh

#set the root user password
echo -e "$ROOTPASSWORD\n$ROOTPASSWORD" | passwd

# create a normal user and make it a sudoer
useradd -rm -d /home/$USER -s /usr/bin/zsh -p "$(openssl passwd -1 $PASSWORD)" $USER
echo "$USER ALL=(ALL:ALL) ALL" >>/etc/sudoers

# Install more things
btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile
swapon /swap/swapfile

echo "" >>/etc/fstab
echo "/swap/swapfile none swap defaults 0 0" >>/etc/fstab

# set time zone and hwclock a

ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime
hwclock --systohc

# Generate the locales
sed -i 's/#en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen
echo "LANG=en_CA.UTF-8" >>/etc/locale.conf
locale-gen

# Hostname
echo "march" >>/etc/hostname

# Hosts file
cp hosts /etc/hosts

# User and Root password

# Apple T2 chip thingy
sed -i 's/Modules=()/Modules=(apple-bce)/g' /etc/mkinitcpio.conf
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
systemctl enable user@0.service

# to make sure DNS works right
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# grub things
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="quiet splash intel_iommu=on iommu=pt pcie_ports=compat"/g' /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

echo "DONE!!!! exit and reboot"
