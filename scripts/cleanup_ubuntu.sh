# Clean up unneeded packages.
apt-get -y purge apparmor dictionaries-common eject friendly-recovery ftp fuse gdisk hdparm landscape-common language-pack-gnome-en laptop-detect libicu52:amd64 linux-headers-3.16.0-37 linux-image-extra-3.16.0-37-generic telnet tmux wamerican wbritish wireless-tools ufw whiptail libx11-6 libx11-data libxdmcp6 libxau6 xkb-data
apt-get -y autoremove
apt-get -y clean
> /root/.ssh/authorized_keys
shutdown -h now
