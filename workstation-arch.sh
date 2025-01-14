#!/bin/sh

user=james
fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed man
sudo pacman -S --noconfirm --needed nfs-utils
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed sudo
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed gnupg
sudo pacman -S --noconfirm --needed ca-certificates
sudo pacman -S --noconfirm --needed curl
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed gnupg
sudo pacman -S --noconfirm --needed lsb-release
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed npm
sudo pacman -S --noconfirm --needed htop
sudo pacman -S --noconfirm --needed file
sudo pacman -S --noconfirm --needed jq
sudo pacman -S --noconfirm --needed fzf
sudo pacman -S --noconfirm --needed github-cli
sudo pacman -S --noconfirm --needed ripgrep
sudo pacman -S --noconfirm --needed neovim
sudo pacman -S --noconfirm --needed ansible
sudo pacman -S --noconfirm --needed base-devel 
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed openssh 
sudo pacman -S --noconfirm --needed obsidian 

# SSH - bounce it to get it going
sudo systemctl restart sshd.service 

# YAY PACKAGE MANAGER
echo "===== yay"
sudo rm -rf /home/${user}/yay
git clone https://aur.archlinux.org/yay.git /home/${user}/yay
cd /home/${user}/yay
makepkg -si --noconfirm
cd - 

# BRAVE BROWSER
echo "===== brave browser"
yay -S --noconfirm brave-bin

# TMUX PACKAE MANAGER
echo "===== tmux package manager"
rm -rf /home/${user}/.tmux
git clone https://github.com/tmux-plugins/tpm /home/$user/.tmux/plugins/tpm

# ALACRITTY
echo "===== alacritty"
./alacritty.sh

# ZSH SYNTAX HIGHTLIGHTING
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# NVCHAD
echo "===== nvchad"
rm -rf /home/${user}/.config/nvim
git clone https://github.com/NvChad/starter /home/${user}/.config/nvim 

rm -rf /home/${user}/.tmux
git clone https://github.com/tmux-plugins/tpm /home/$user/.tmux/plugins/tpm
# TOKYONIGHT
git clone https://github.com/folke/tokyonight.nvim.git

# bat 
# already installed above..
#
mkdir /home/${user}/.config/bat/themes
ln /home/${user}/tokyonight.nvim/extras/sublime/tokyonight_moon.tmTheme /home/${user}/.config/bat/theme/
ln /home/${user}/tokyonight.nvim/extras/sublime/tokyonight_day.tmTheme /home/${user}/.config/bat/theme/
ln /home/${user}/tokyonight.nvim/extras/sublime/tokyonight_night.tmTheme /home/${user}/.config/bat/theme/
ln /home/${user}/tokyonight.nvim/extras/sublime/tokyonight_storm.tmTheme /home/${user}/.config/bat/theme/
bat cache --build


# OHMYZSH
echo "===== ohmyzsh"
rm -rf /home/${user}/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${user}/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /home/${user}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# OHMYPOSH
echo "===== oh my posh"
curl -s https://ohmyposh.dev/install.sh | bash -s

# MY DOTFILES
echo "===== my dotfiles"
rm -rf /home/${user}/dotfiles 
git clone https://github.com/jamesstorm/dotfiles /home/${user}/dotfiles

rm -rf /home/${user}/bat/config /home/${user}/.zshrc /home/${user}/.tmux.conf /home/${user}/.gitconfig /home/${user}/.config/ohmyposh/omp.toml
ln -s /home/${user}/dotfiles/.zshrc-arch /home/${user}/.zshrc #### NOTE THAT THIS POINTS AT THE ARCH VERSION
ln -s /home/${user}/dotfiles/.tmux.conf /home/${user}/.tmux.conf
ln -s /home/${user}/dotfiles/.gitconfig /home/${user}/.gitconfig
mkdir -p /home/${user}/.config/ohmyposh
ln -s /home/${user}/dotfiles/omp.toml /home/${user}/.config/ohmyposh/
ln -s /home/${user}/dotfiles/bat-config /home/${user}/.config/bat/config
ln -s /home/${user}/dotfiles/colorscheme.lua /home/${user}/.config/nvim/lua/plugins/

# MAKE SURE THE USER OWNS ALL THE THINGS IN THEIR HOME
echo "===== chmod all the user's things"
sudo chown -R ${user}:${user} /home/${user}

# Set the locale because ansible-vault will not work without it.
#echo "===== locales"
#locale-gen en_US.UTF-8

# Some things (like nvim and ansible)  were installed in places that PATH does not know. Fix that.
#echo "PATH=/squashfs-root/usr/bin:/home/${user}/.local/bin:$PATH" >>/home/${user}/.zshrc

# Make sure the user has zsh as the default shell
echo "===== setting user shell to zsh"
sudo chsh --shell /usr/bin/zsh ${user}

# Font and Gnome settings
echo "===== font and gnome settings"
sudo wget -P /usr/local/share/fonts/ ${fonturl}
rm -rf /home/${user}/.config/autostart
ln -s /home/${user}/dotfiles/autostart /home/${user}/.config/autostart
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# mount shares
echo "===== mounting shares from nas"
function fstab_add_entry() {
  source_str=$1
  filename="/etc/fstab"  # replace with your file name

  if ! grep -qF "$source_str" "$filename"; then
    echo "$source_str" | sudo tee -a "$filename"
  fi
} 
sudo mkdir -p /mnt/homeshare /mnt/media
fstab_add_entry "192.168.6.201:/mnt/Foo/homeshare /mnt/homeshare nfs defaults 0 0"
rm -rf /home/${user}/.tmux
git clone https://github.com/tmux-plugins/tpm /home/$user/.tmux/plugins/tpm
fstab_add_entry "192.168.6.201:/mnt/mr_pool/media /mnt/media nfs defaults 0 0"

sudo systemctl daemon-reload
sudo mount -a
