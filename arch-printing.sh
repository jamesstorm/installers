#!/bin/bash

# cups
pacman -S --noconfirm cups
systemctl enable cups
systemctl start cups

# Brother Drivers
yay -S --noconfirm brother-dcpl2550dw
# system
pacman -S --noconfirm system-config-printer
