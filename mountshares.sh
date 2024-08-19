
# mount shares
echo "===== mounting shares from nas"
function fstab_add_entry() {
  source_str=$1
  filename="/etc/fstab"  # replace with your file name

  if ! grep -qF "$source_str" "$filename"; then
    echo "$source_str" | sudo tee -a "$filename"
  fi
} 
sudo mkdir /mnt/homeshare /mnt/media
fstab_add_entry "192.168.6.201:/mnt/Foo/homeshare /mnt/homeshare nfs defaults 0 0"
fstab_add_entry "192.168.6.201:/mnt/mr_pool/media /mnt/media nfs defaults 0 0"

sudo systemctl daemon-reload
sudo mount -a
