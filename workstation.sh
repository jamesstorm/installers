#!/bin/sh

# first... make sure the user is in sudoers
# su -
# visudo
# add this line after the similar line for root
# james ALL=(ALL:ALL) ALL

# Meslo NerdFont is here:
# https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz

user=james
fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"

apt-get update
apt-get upgrade -y

apt-get install \
  nala \
  zsh \
  wget \
  sudo \
  git \
  software-properties-common \
  gnupg \
  ssh \
  python3-venv \
  apt-transport-https \
  ca-certificates \
  curl \
  wget \
  screenfetch \
  python3-pip \
  python3-venv \
  gnupg \
  lsb-release \
  openssh-server \
  tmux

npm \
  htop \
  file \
  jq \
  -y
apt-get upgrade -y

# GitHub CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
  sudo apt update &&
  sudo apt install gh -y

# Neovim and Lazy
./neovim-tar.sh
./lazy.sh

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# OHMYZSH AND POWERLINE10K
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${user}/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/${user}/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions /home/${user}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# MY DOTFILES
git clone https://github.com/jamesstorm/dotfiles /home/${user}/dotfiles
ls -al /home/${user}/dotfiles
rm -rf /home/${user}/.zshrc
rm -rf /home/${user}/.tmux.conf
rm -rf /home/${user}/.p10k.zsh
ln /home/${user}/dotfiles/.zshrc /home/${user}/.zshrc
ln /home/${user}/dotfiles/.tmux.conf /home/${user}/.tmux.conf
ln /home/${user}/dotfiles/.p10k.zsh /home/${user}/.p10k.zsh
ln /home/${user}/dotfiles/.gitconfig /home/${user}/.gitconfig

# TMUX POWERLINE
git clone https://github.com/erikw/tmux-powerline.git /home/${user}/.config/tmux/tmux-powerline

#brew
./brew.sh

# Some brew things
brew install fzf bat dust tldr

# MAKE SURE THE USER OWNS ALL THE THINGS IN THEIR HOME
chown -R ${user}:${user} /home/${user}

apt-get install locales locales-all -y

# Set the locale because ansible-vault will not work without it.
locale-gen en_US.UTF-8

apt install ansible -y

# Some things (like nvim and ansible)  were installed in places that PATH does not know. Fix that.
echo "PATH=/squashfs-root/usr/bin:/home/${user}/.local/bin:$PATH" >>/home/${user}/.zshrc

# Set the timezone
ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

chsh --shell /bin/zsh ${user}

# Font and Gnome Terminal settings
wget -P /home/${user}/.local/share/fonts/ ${fonturl}
dconf load /org/gnome/terminal/ </home/${user}/dotfiles/gnome_terminal_settings_backup.txt
