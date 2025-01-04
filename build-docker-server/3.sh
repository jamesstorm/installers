#!/bin/bash

# set up the mounts to TrueNAS
#
#
apt install nfs-common
mkdir -p /mnt/media
mkdir -p /mnt/appdata
echo "192.168.5.201:/mnt/media/media /mnt/media nfs defaults 0 0" >>/etc/fstab
echo "192.168.5.201:/mnt/mr_pool/appdata /mnt/appdata nfs defaults 0 0" >>/etc/fstab

systemctl daemon-reload
mount -a
ls /mnt/media
ls /mnt/appdata

# restore the backups for the docker containers
#
#
cd /home/james/prime/environment/
./backup/appdata-restore.sh

#start the containers.
docker compose up -d

# fin
