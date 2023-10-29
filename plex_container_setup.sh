#!/bin/sh

# fix the slow login issue

systemctl mask systemd-logind
pam-auth-update >deselect "Register user sessions in the systemd control group hierarchy"

# fix ping cap_net thing
sudo setcap cap_net_raw+ep /bin/ping

apt install tmux zsh sudo python3-pip ansible-core gh -y
groupadd --gid 3000 mediausers
useradd --uid 3000 -m mediauser

usermod -aG mediausers mediauser
usermod -aG sudo mediausers
echo "Enter a password for mediauser"
passwd mediauser
mkdir /mnt/mediashare
echo "192.168.5.201:/mnt/mr_pool/media /mnt/mediashare nfs defaults 0 0" >>/etc/fstab
