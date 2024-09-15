#!/bin/bash

sudo pacman -S --needed steam
sudo pacman -S --needed vulkan-radeon
sudo pacman -S --needed amdvlk
yay -S --needed vulkan-amdgpu-pro
sudo pacman -S --needed xdg-desktop-portal
sudo pacman -S --needed ttf-liberation
sudo pacman -S --needed lib32-systemd
yay -S --needed steamcmd
sudo echo "vm.max_map_count = 2147483642" | sudo tee /etc/sysctl.d/80-gamecompatibility.conf
