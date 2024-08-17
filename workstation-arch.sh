#!/bin/sh
# first... make sure the user is in sudoers
# su -
# visudo
# add this line after the similar line for root
# james all=(all:all) all


user=james
fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/meslo/l/regular/meslolglnerdfontmono-regular.ttf"

sudo pacman -Syu
sudo pacman -S --noconfirm --needed  yay
sudo pacman -S --noconfirm --needed  man
sudo pacman -S --noconfirm --needed  nfs-utils
sudo pacman -S --noconfirm --needed  zsh
sudo pacman -S --noconfirm --needed  wget
sudo pacman -S --noconfirm --needed  sudo
sudo pacman -S --noconfirm --needed  git
sudo pacman -S --noconfirm --needed  gnupg
sudo pacman -S --noconfirm --needed  ca-certificates
sudo pacman -S --noconfirm --needed  curl
sudo pacman -S --noconfirm --needed  wget
sudo pacman -S --noconfirm --needed  neofetch
sudo pacman -S --noconfirm --needed  gnupg
sudo pacman -S --noconfirm --needed  lsb-release
sudo pacman -S --noconfirm --needed  tmux
sudo pacman -S --noconfirm --needed  npm
sudo pacman -S --noconfirm --needed  htop
sudo pacman -S --noconfirm --needed  file
sudo pacman -S --noconfirm --needed  jq
sudo pacman -S --noconfirm --needed  fzf
sudo pacman -S --noconfirm --needed  github-cli
sudo pacman -S --noconfirm --needed  ripgrep
sudo pacman -S --noconfirm --needed  neovim
sudo pacman -S --noconfirm --needed  ansible
sudo pacman -S --needed --noconfirm base-devel 

# NEOVIM
git clone https://github.com/NvChad/starter /home/${user}/.config/nvim && nvim

# YAY
git clone https://aur.archlinux.org/yay.git /home/${user}/
cd yay
makepkg -si --noconfirm
cd ~

# OHMYZSH
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${user}/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /home/${user}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# OHMYPOSH
curl -s https://ohmyposh.dev/install.sh | bash -s

# MY DOTFILES
git clone https://github.com/jamesstorm/dotfiles /home/${user}/dotfiles
rm -rf /home/${user}/.zshrc /home/${user}/.tmux.conf /home/${user}/.gitconfig /home/${user}/.config/ohmyposh/omp.toml
ln -s /home/${user}/dotfiles/.zshrc-arch /home/${user}/.zshrc #### NOTE THAT THIS POINTS AT THE ARCH VERSION
ln -s /home/${user}/dotfiles/.tmux.conf /home/${user}/.tmux.conf
ln -s /home/${user}/dotfiles/.gitconfig /home/${user}/.gitconfig
mkdir /home/${user}/.config/ohmyposh
ln -s /home/${user}/dotfiles/omp.toml /home/${user}/.config/ohmyposh/

# MAKE SURE THE USER OWNS ALL THE THINGS IN THEIR HOME
sudo hown -R ${user}:${user} /home/${user}


# Set the locale because ansible-vault will not work without it.
locale-gen en_US.UTF-8

# Some things (like nvim and ansible)  were installed in places that PATH does not know. Fix that.
echo "PATH=/squashfs-root/usr/bin:/home/${user}/.local/bin:$PATH" >>/home/${user}/.zshrc

# Set the timezone
sudo ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

# Make sure the user has zsh as the default shell
sudo chsh --shell /bin/zsh ${user}

# Font and Gnome Terminal settings
sudo wget -P /usr/local/share/fonts/ ${fonturl}
