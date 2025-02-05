#!/bin/bash

# only install yay if pacman also exists
if [ -x /usr/bin/pacman ]; then
  sudo pacman -S --needed --noconfirm base-devel
  cd ~
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi
