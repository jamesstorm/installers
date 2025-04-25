#/bin/bash -e



FSTAB_LINE="192.168.4.201:/mnt/media/rpicam1 /rpicam1 nfs defaults 0 0"






# run as root
if [ $(id -u) -ne 0 ]; then
  echo "please run as root"
  exit 1
fi

# update the things
apt update
apt upgrade

apt install git ansible
apt install stow

sudo -u james git clone https://github.com/jamesstorm/installers
sudo -u james /home/james/installers/dotfiles.sh

# mount share from truenas
mkdir -p /rpicam1


# Check if line already exists in /etc/fstab
if ! grep -Fxq "$FSTAB_LINE" /etc/fstab; then
  echo "$FSTAB_LINE" >> /etc/fstab
  echo "Line added to /etc/fstab"
else
  echo "Line already exists in /etc/fstab"
fi


systemctl daemon-reload

mount -a
