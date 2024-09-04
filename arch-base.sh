#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then # root user uid is 0
  echo "Please run as root"
  exit 1
fi
pacman -Syu --noconfirm
pacman -S --noconfirm --needed btop
pacman -S --noconfirm --needed man
pacman -S --noconfirm --needed nfs-utils
pacman -S --noconfirm --needed zsh
pacman -S --noconfirm --needed wget
pacman -S --noconfirm --needed sudo
pacman -S --noconfirm --needed git
pacman -S --noconfirm --needed gnupg
pacman -S --noconfirm --needed ca-certificates
pacman -S --noconfirm --needed curl
pacman -S --noconfirm --needed wget
pacman -S --noconfirm --needed neofetch
pacman -S --noconfirm --needed gnupg
pacman -S --noconfirm --needed lsb-release
pacman -S --noconfirm --needed tmux
pacman -S --noconfirm --needed npm
pacman -S --noconfirm --needed htop
pacman -S --noconfirm --needed file
pacman -S --noconfirm --needed jq
pacman -S --noconfirm --needed fzf
pacman -S --noconfirm --needed github-cli
pacman -S --noconfirm --needed ripgrep
pacman -S --noconfirm --needed ansible
pacman -S --noconfirm --needed base-devel
pacman -S --noconfirm --needed bat
pacman -S --noconfirm --needed openssh
pacman -S --noconfirm --needed obsidian
pacman -S --noconfirm --needed yay
pacman -S --noconfirm --needed rsync
pacman -S --noconfirm --needed libreoffice-fresh
pacman -S --noconfirm --needed bc
pacman -S --noconfirm --needed fio
pacman -S --noconfirm --needed dmidecode
pacman -S --noconfirm --needed ethtool
yay -S --noconfirm --needed brave-browser
pacman -S --noconfirm --needed ethtool

# SSH - bounce it to get it going
systemctl enable sshd.service
systemctl restart sshd.service
