# Clean up unneeded packages.
apt-get -y purge apparmor dictionaries-common eject friendly-recovery ftp fuse gdisk hdparm landscape-common language-pack-gnome-en laptop-detect libicu52:amd64 telnet tmux wamerican wbritish wireless-tools ufw whiptail libx11-6 libx11-data libxdmcp6 libxau6 xkb-data
dpkg -l linux-{image,headers}-* | awk '/^ii/{print $2}' | egrep '[0-9]+\.[0-9]+\.[0-9]+' | grep -v $(uname -r) | xargs sudo apt-get -y purge
apt-get -y autoremove
apt-get -y clean
> /root/.ssh/authorized_keys
shutdown -h now
