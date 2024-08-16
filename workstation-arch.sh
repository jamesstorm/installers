#!/bin/sh
#hello world
# first... make sure the user is in sudoers
# su -
# visudo
# add this line after the similar line for root
# james ALL=(ALL:ALL) ALL

# Meslo NerdFont is here:
# https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz

user=james
fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"

pacman -S \
  nfs-utils \
  zsh \
  wget \
  sudo \
  git \
  gnupg \
  ca-certificates \
  curl \
  wget \
  screenfetch \
  gnupg \
  lsb-release \
  tmux \
  npm \
  htop \
  file \
  jq \
  fzf \
  gh \
  ripgrep \
  -y

#TMUX Package Manager
git clone https://github.com/tmux-plugins/tpm /home/${user}/.tmux/plugins/tpm

# OHMYZSH
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${user}/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /home/${user}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# MY DOTFILES
git clone https://github.com/jamesstorm/dotfiles /home/${user}/dotfiles
ls -al /home/${user}/dotfiles
rm -rf /home/${user}/.zshrc
rm -rf /home/${user}/.tmux.conf
ln -s /home/${user}/dotfiles/.zshrc-arch /home/${user}/.zshrc #### NOTE THAT THIS POINTS AT THE ARCH VERSION
ln -s /home/${user}/dotfiles/.tmux.conf /home/${user}/.tmux.conf
ln -s /home/${user}/dotfiles/.gitconfig /home/${user}/.gitconfig

# MAKE SURE THE USER OWNS ALL THE THINGS IN THEIR HOME
chown -R ${user}:${user} /home/${user}

pacman -S locales locales-all -y

# Set the locale because ansible-vault will not work without it.
locale-gen en_US.UTF-8

# Some things (like nvim and ansible)  were installed in places that PATH does not know. Fix that.
echo "PATH=/squashfs-root/usr/bin:/home/${user}/.local/bin:$PATH" >>/home/${user}/.zshrc

# Set the timezone
ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

pacman -S ansible -y

# Set the timezone
ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime
# chsh --shell /bin/zsh ${user}

chsh --shell /bin/zsh ${user}

# Font and Gnome Terminal settings
wget -P /home/${user}/.local/share/fonts/ ${fonturl}
