#/bin/bash

#test for internet. Script will exit if no internet.
source ./scripts/internet-test.sh

# load some configuration
source ./config.sh

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
