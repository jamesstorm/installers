#!/bin/sh
# fix the slow login issue

systemctl mask systemd-logind
pam-auth-update >deselect "Register user sessions in the systemd control group hierarchy"

# fix ping cap_net thing
sudo setcap cap_net_raw+ep /bin/ping

apt update
apt upgrade -y
apt install dirmngr ca-certificates software-properties-common apt-transport-https tmux zsh sudo python3-pip ansible-core gh nfs-common curl -y
groupadd --gid 3000 mediausers
useradd --uid 3000 -m mediauser

usermod -aG mediausers mediauser
usermod -aG sudo mediausers
echo "Enter a password for mediauser"
passwd mediauser
mkdir /mnt/mediashare
echo "192.168.5.201:/mnt/mr_pool/media /mnt/mediashare nfs defaults 0 0" >>/etc/fstab

curl -sS https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | tee /usr/share/keyrings/plex.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" >/etc/apt/sources.list.d/plexmediaserver.list
apt update

apt update && apt install plexmediaserver -y
