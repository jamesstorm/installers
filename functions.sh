remkdir() {
  if [ -d $1 ]; then
    rm -rf $1
  fi
  mkdir -p $1
}

link_dotfile() {
  echo "link_dotfile $1 $2 $3"
  SOURCE=$1
  DEST_PATH=$2
  DEST_FILENAME=$3
  DEST_FULL=$DEST_PATH/$DEST_FILENAME
  if [[ -f $DEST_FULL ]]; then
    #  echo "deleting $DEST_FULL"
    rm $DEST_FULL
  fi
  mkdir -p $DEST_PATH
  ln -s $SOURCE $DEST_PATH/$DEST_FILENAME

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
