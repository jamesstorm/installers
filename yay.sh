#!/bin/bash 

sudo pacman -S --needed --noconfirm base-devel 
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm


