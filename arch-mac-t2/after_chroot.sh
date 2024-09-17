#/bin/bash

cd $HOME/installers/arch/

# Install more things
source ./pacman.sh

source ./swap.sh

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
source ./services.sh
# to make sure DNS works right
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# grub things
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="quiet splash intel_iommu=on iommu=pt pcie_ports=compat"/g' /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

source ./users.sh

echo "DONE!!!! exit and reboot"
