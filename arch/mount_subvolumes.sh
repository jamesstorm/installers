#!/bin/bash

mount -o noatime,compress=lzo,subvol=@root /dev/nvme0n1p3 /mnt
mount --mkdir -o noatime,compress=lzo,subvol=@home /dev/nvme0n1p3 /mnt/home
mount --mkdir -o noatime,compress=lzo,subvol=@srv /dev/nvme0n1p3 /mnt/srv
mount --mkdir -o noatime,compress=lzo,subvol=@tmp /dev/nvme0n1p3 /mnt/tmp
mount --mkdir -o noatime,compress=lzo,subvol=@opt /dev/nvme0n1p3 /mnt/opt
mount --mkdir -o noatime,compress=lzo,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots
mount --mkdir -o nodatacow,subvol=@swap /dev/nvme0n1p3 /mnt/swap
mount --mkdir -o nodatacow,subvol=@var /dev/nvme0n1p3 /mnt/var
mount --mkdir /dev/nvmen0n1p1 /mount/boot
