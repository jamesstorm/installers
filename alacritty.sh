#!/bin/bash
source ~/installers/functions.sh


main() {
  install_app "alacritty" 

  if [ -d ~/.config/alacritty ]; then
    rm  rf ~/.config/alacritty
  fi

  mkdir ~/.config/alacritty
  ln -s ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
  mkdir -p ~/.config/alacritty/themes
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

}


main
