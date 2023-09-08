#!/bin/sh

user=james

apt-get install curl zsh zplug

# GitHub CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install gh -y

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage /home/${user}/
chmod +x /home/${user}/nvim.appimage
./home/${user}/nvim.appimage --appimage-extract

git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/${user}/.local/share/nvim/site/pack/packer/start/packer.nvim

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# OHMYZSH AND POWERLINE10K
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/${user}/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/${user}/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions /home/${user}/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# MY DOTFILES
git clone https://github.com/jamesstorm/dotfiles /home/${user}/dotfiles
ls -al /home/${user}/dotfiles
rm -rf /home/${user}/.zshrc
rm -rf /home/${user}/.tmux.conf
rm -rf /home/${user}/.p10k.sh
ln /home/${user}/dotfiles/.zshrc /home/${user}/.zshrc
ln /home/${user}/dotfiles/.tmux.conf /home/${user}/.tmux.conf
ln /home/${user}/dotfiles/.p10k.zsh /home/${user}/.p10k.zsh
ln /home/${user}/dotfiles/.gitconfig /home/${user}/.gitconfig
# TMUX POWERLINE
git clone https://github.com/erikw/tmux-powerline.git /home/${user}/.config/tmux/tmux-powerline


echo "Done"
