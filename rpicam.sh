#/bin/bash -e

if [ ! -x /usr/bin/stow ] || [ ! -x /usr/bin/git ] || [ ! -x /usr/bin/gh ] || [ ! -x /usr/bin/ansible-vault ]; then
  echo "one of stow, git, gh, or ansible not found"
  exit 1
fi



FSTAB_LINE="192.168.4.201:/mnt/media/rpicam1 /rpicam1 nfs defaults 0 0"






# run as root
if [ $(id -u) -ne 0 ]; then
  echo "please run as root"
  exit 1
fi

# update the things



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
