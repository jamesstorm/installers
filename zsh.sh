# install all the things I like in my zsh environment


if [ "$(id -u)" -eq 0 ]; then # root user uid is 0
  echo "Do not run as root."
  exit 1
fi



# alias my system-wide zshenv
[ -d /etc/zsh ] && sudo rm -rf /etc/zsh 
sudo mkdir -p /etc/zsh
sudo ln -s /home/${USER}/dotfiles/zsh/zshenv /etc/zsh/zshenv



# Alias my dotfiles
[ -d $ZDOTDIR ] && rm -rf $ZDOTDIR #purge existing if exists
mkdir -p $ZDOTDIR/plugins
ln -s $HOME/dotfiles/zsh/.zshrc $ZDOTDIR/.zshrc
ln -s $HOME/dotfiles/zsh/options.zsh $ZDOTDIR/options.zsh
ln -s $HOME/dotfiles/zsh/aliases.zsh $ZDOTDIR/aliases.zsh

# PLUGINS

## OHMYPOSH
curl -s https://ohmyposh.dev/install.sh | bash -s

## ZSH_AUTOSUGGESTIONS
[ -d $ZDOTDIR/plugins/zsh-autosuggestions ] && rm -rf $ZDOTDIR/plugins/zsh-autosuggestions
mkdir -p $ZDOTDIR/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions

## ZSH SYNTAX highlighting
[ -d $ZDOTDIR/plugins/zsh-syntax-highlighting ] && rm -rf $ZDOTDIR/plugins/zsh-syntax-highlighting
mkdir -p $ZDOTDIR/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting





