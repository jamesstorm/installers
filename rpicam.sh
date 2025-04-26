#/bin/bash -e
#
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



# set up virtual environments:
rm -rf /home/james/motioneye/*
python -m venv /home/james/motioneye




apt install -y python3-pip

apt install -y ffmpeg v4l-utils curl wget libmariadb3 libpq5 libmicrohttpd12
mkdir -p /var/log/motion
chown -R motion:motion /var/log/motion
apt install -y motion
sed -i 's/daemon off/daemon on/' /etc/motion/motion.conf
apt install -y libssl-dev libcurl4-openssl-dev libjpeg-dev libz-dev
/home/james/motioneye/bin/pip3 install motioneye
mkdir -p /etc/motioneye
cp /home/james/motioneye/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
cp /home/james/motioneye/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
systemctl daemon-reexec
systemctl enable motioneye
systemctl start motioneye





