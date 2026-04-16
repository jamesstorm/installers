#!/bin/sh

user=james
fonturl="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFontMono-Regular.ttf"

# Font and Gnome settings
echo "===== font and gnome settings"
sudo wget -P /usr/local/share/fonts/ ${fonturl}
rm -rf /home/${user}/.config/autostart
ln -s /home/${user}/dotfiles/autostart /home/${user}/.config/autostart
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
