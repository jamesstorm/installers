#!/bin/sh

if [ -x /usr/bin/pacman ]; then
   yay -S neovim 
elif [ -x /usr/bin/apt ]; then
   # probably debian, so install the latest from the tar file in github
   [ ! -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
   tar -C $HOME/.local/bin -xzf nvim-linux64.tar.gz
   rm nvim-linux64.tar.gz 
   echo "PATH=$HOME/.local/bin/nvim-linux64/bin:$PATH" >> $ZDOTDIR/.zshrc
fi

