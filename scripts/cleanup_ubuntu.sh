# Clean up unneeded packages.
apt-get -y purge accountsservice apparmor console-setup dosfstools eject fuse geoip-database gir1.2-glib-2.0 hdparm keyboard-configuration krbb5-locales language-pack-de laptop-detect parted powermgmt-base python telnet xauth xkb-data
dpkg -l linux-{image,headers}-* | awk '/^ii/{print $2}' | egrep '[0-9]+\.[0-9]+\.[0-9]+' | grep -v $(uname -r) | xargs sudo apt-get -y purge
apt-get -y autoremove
apt-get -y clean
> /root/.ssh/authorized_keys
shutdown -h now
