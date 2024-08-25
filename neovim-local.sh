#!/bin/sh

# Installs nvim in the current user's /local/bin

LOCAL_BIN=$HOME/.local/bin
NVIM_DIR=$HOME/.local/bin/nvim-linux64

[ ! -d $LOCAL_BIN ] && mkdir -p $LOCAL_BIN
[ -d $NVIM_DIR ] && rm -rf $NVIM_DIR
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $HOME/.local/bin -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo "PATH=$NVIM_DIR/bin:$PATH" >>$ZDOTDIR/.zshrc
