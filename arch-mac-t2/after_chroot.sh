#/bin/bash

cd $HOME/installers/arch-mac-t2/

# Install more things
source ./scripts/pacman.sh

# create and enable swap file
source ./scripts/swap.sh

# set time zone and hwclock a
source ./scripts/timezone-hwclock.sh

# Generate the locales
source ./scripts/locale.sh

# Hostname
echo "march" >>/etc/hostname

# Hosts file
cp hosts /etc/hosts

# User and Root password

# Apple T2 chip thingy
source ./scripts/apple-t2.sh

#enable some services
source ./scripts/services.sh

# to make sure DNS works right
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# grub things
source ./scripts/grub.sh

source ./scripts/users.sh

echo "DONE!!!! exit and reboot"
