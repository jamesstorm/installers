#!/bin/sh

# fix the slow login issue

systemctl mask systemd-logind
pam-auth-update >deselect "Register user sessions in the systemd control group hierarchy"

# requires git

apt install tmux zsh sudo python3-pip ansible-core gh -y
groupadd --gid 3000 mediausers
useradd --uid 3000 -m mediauser

usermod -aG mediausers mediauser
usermod -aG sudo mediauser
passwd mediauser
