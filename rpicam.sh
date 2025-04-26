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


sudo apt install python3-pip
sudo pip3 install 'https://github.com/motioneye-project/motioneye/archive/dev.tar.gz' --break-system-packages
sudo motioneye_init

systemctl enable motioneye
systemctl start motioneye
systemctl status


apt install v4l2loopback-dkms
echo "v4l2loopback" >> /etc/modules
echo 'options v4l2loopback devices=1 video_nr=0 card_label="rpicam1" exclusive_caps=1' >> /etc/modprobe.d/v4l2loopback.conf
apt install ffmpeg
echo <<EOT > /usr/local/bin/camera-stream.sh
#!/bin/bash
libcamera-vid -t 0 --inline --width 640 --height 480 --framerate 25 --codec mjpeg | ffmpeg -i - -f v4l2 -vcodec rawvideo -pix_fmt yuv420p /dev/video0
EOT
chmod +x /usr/local/bin/camera-stream.sh
echo <<EOT > /etc/systemd/system/camera-stream.service
[Unit]
Description=Pipe libcamera feed to v4l2loopback
After=multi-user.target

[Service]
ExecStart=/usr/local/bin/camera-stream.sh
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOT


systemctl daemon-reload
systemctl enable camera-stream.service
systemctl start camera-stream.service






