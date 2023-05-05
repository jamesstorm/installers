#/bin/bash


mv ~/.tmux.conf ~/.tmux.conf.backup
ln ~/dotfiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/erikw/tmux-powerline.git /home/james/.config/tmux/tmux-powerline
