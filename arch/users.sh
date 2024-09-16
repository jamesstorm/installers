#!/bin/bash

echo -e "james\njames" | passwd
useradd -rm -d /home/james -s /bin/zsh -u 1000 -g 1000 -G sudo -p "$(openssl passwd -1 james)" james
echo "james ALL=(ALL:ALL) ALL" >>/etc/sudoers
