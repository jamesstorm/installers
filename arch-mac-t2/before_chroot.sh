#/bin/bash

source ./config.sh

# Need to be connected to wifi before this runs
iwctl station wlan0 show

# time and date
source ./scripts/timedate.sh

# set pacman mirrorlist
source .scripts/reflector.sh

# partition
source ./scripts/partition.sh

# format disk, create subvolumes, mount the subvolumes and boot
source ./scripts/format-subvolume-mount.sh

# Install base packages
source ./scripts/pacstrap.sh

# generate the fstab
source ./scripts/fstab-create.sh

echo "#####"
echo "DONE - now run arch-chroot /mnt"
