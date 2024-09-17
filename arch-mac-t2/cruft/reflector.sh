#!/bin/bash

pacman -Sy reflector
reflector -c Canada -a 6 --sort rate --save /etc/pacman.d/mirrorlist
