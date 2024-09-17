#!/bin/bash

USER=james
PASSWORD=james
ROOTPASSWORD=james

#set the root user password
echo -e "$ROOTPASSWORD\n$ROOTPASSWORD" | passwd

# create a normal user and make it a sudoer
useradd -rm -d /home/$USER -s /usr/bin/zsh -p "$(openssl passwd -1 $PASSWORD)" $USER
echo "$USER ALL=(ALL:ALL) ALL" >>/etc/sudoers
