# Clean up unneeded packages.
apt-get -y purge apparmor dictionaries-common eject friendly-recovery ftp fuse gdisk hdparm landscape-common language-pack-gnome-en laptop-detect libicu52:amd64 linux-headers-3.16.0-30 linux-image-extra-3.16.0-30-generic python3:i386 python3.4:i386 python3-minimal:i386 python3.4-minimal:i386 telnet tmux wamerican wbritish wireless-tools
apt-get -y autoremove
apt-get -y clean
> /root/.ssh/authorized_keys
shutdown -h now
