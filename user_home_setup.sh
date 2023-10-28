!#/bin/sh



mkdir ~/.ssh


# OHMYZSH AND POWERLINE10K
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# MY DOTFILES
git clone https://github.com/jamesstorm/dotfiles ~/dotfiles
ls -al ~/dotfiles
rm -rf ~/.zshrc
rm -rf ~/.tmux.conf
rm -rf ~/.p10k.sh
ln ~/dotfiles/.zshrc ~/.zshrc
ln ~/dotfiles/.tmux.conf ~/.tmux.conf
ln ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln ~/dotfiles/.gitconfig ~/.gitconfig
# TMUX POWERLINE
git clone https://github.com/erikw/tmux-powerline.git ~/.config/tmux/tmux-powerline

# MAKE SURE THE USER OWNS ALL THE THINGS IN THEIR HOME
#chown -R ${user}:${user} ~



chsh -s /bin/zsh
