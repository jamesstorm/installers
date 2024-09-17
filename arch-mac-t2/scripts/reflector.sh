#!/bin/bash
pacman -Sy --noconfirm reflector
reflector -c Canada -a 6 --sort rate --save /etc/pacman.d/mirrorlist
