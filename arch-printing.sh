#!/bin/bash

# cups
sudo pacman -S --noconfirm cups
sudo systemctl enable cups
sudo systemctl start cups

# Brother Drivers
yay -S --noconfirm brother-dcpl2550dw
# system
sudo pacman -S --noconfirm system-config-printer
