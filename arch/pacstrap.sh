#!/bin/bash

pacstrap /mnt base \
  linux-t2 \
  linux-t2-headers \
  apple-t2-audio-config \
  apple-bcm-firmware \
  linux-firmware \
  iwd \
  grub \
  efibootmgr \
  tiny-dfr \
  t2fanrd \
  btrfs-progs \
  intel-ucode \
  networkmanager \
  neovim \
  stow \
  git \
  unzip \
  sudo \
  nfs-utils \
  wget \
  neofetch \
  bat \
  openssh \
  base-devel \
  ripgrep \
  htop \
  fzf \
  github-cli \
  ca-certificates \
  jq \
  gnome \
  gdm \
  ansible \
  file \
  lsb-release \
  ttf-meslo-nerd
