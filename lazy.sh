#!/bin/bash
#
#

backupsuffix=$(date +%s)

# required
mv ~/.config/nvim ~/.config/nvim.${backupsuffix}

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.${backupsuffix}
mv ~/.local/state/nvim ~/.local/state/nvim.${backupsuffix}
mv ~/.cache/nvim ~/.cache/nvim.${backupsuffix}

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git
