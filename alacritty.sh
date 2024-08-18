#!/bin/bash
source functions.sh


main() {
  install_app "alacritty" 

  if [ -e ~/.config/alacritty.toml ]; then
    echo "found config to delete"
    rm  ~/.config/alacritty.toml
  fi

  ln -s ~/dotfiles/alacritty.toml ~/.config/alacritty.toml 
}


main
