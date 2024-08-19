#!/bin/bash
source ~/installers/functions.sh


main() {
  install_app "alacritty" 

  if [ -d ~/.config/alacritty ]; then
    rm  -rf ~/.config/alacritty
  fi

  mkdir -p ~/.config/alacritty
  ln -s ~/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

}


main
