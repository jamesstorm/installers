
link_dotfile {
  SOURCE=$1
  DESTINATION_PATH=$2
  DESTINATION_FILENAME=$3

  [ -d $DESTINATION_PATH ] && rm -rf $DESTINATION_PATH
  mkdir -p $DESTINATION_PATH
  ln -s $SOURCE $DESTINATION_PATH/$DESTINATION_FILENAME 

}


install_app() {

  if $(is_installed $1); then
    echo "$1 is already installed"
  else
    echo "install_app installing $1"
    if [ -x /usr/bin/pacman ]; then
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

function debug {
  [ $DEBUG -eq -0 ] && echo $1
}
