#!/bin/bash

systemctl enable ModemManager.service
systemctl enable bolt.service
systemctl enable dbus-broker.service
systemctl enable dhcpcd.service
systemctl enable getty@tty1.service
systemctl enable iwd.service
systemctl enable polkit.service
systemctl enable sshd.service
systemctl enable systemd-homed.service
systemctl enable systemd-journald.service
systemctl enable systemd-logind.service
systemctl enable systemd-networkd.service
systemctl enable systemd-nsresourced.service
systemctl enable systemd-resolved.service
systemctl enable systemd-timesyncd.service
systemctl enable systemd-udevd.service
systemctl enable systemd-userdbd.service
systemctl enable t2fanrd.service
systemctl enable tiny-dfr.service # this may fail
systemctl enable user@0.service
