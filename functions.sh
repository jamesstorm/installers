
install_app() {

  if $(is_installed $1); then
    echo "$1 is already installed"
  else
    echo "install_app installing $1"
    if [ -x /usr/bin/pacman ] ; then
      sudo pacman -S $1
    elif [[ -x /usr/bin/apt ]]; then
      sudo apt install $1 -y 
    fi  
  fi

}

is_installed() {
  if [ -x /usr/bin/$1 ]; then
    return 0 # true
  else
    return 1 # false
  fi
}
