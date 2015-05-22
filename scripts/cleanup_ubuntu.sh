# Clean up unneeded packages.
apt-get -y purge accountsservice apparmor console-setup dosfstools eject fuse geoip-database hdparm keyboard-configuration krb5-locales language-pack-de laptop-detect parted powermgmt-base telnet xauth xkb-data  > /dev/null && echo "Packages cleaned up!" || echo "wat"
dpkg -l linux-{image,headers}-* | awk '/^ii/{print $2}' | egrep '[0-9]+\.[0-9]+\.[0-9]+' | grep -v $(uname -r) | xargs sudo apt-get -y purge > /dev/null && echo "Unused Kernel-shit removed!" || echo "wat2"
apt-get -y autoremove
apt-get -y clean
rm -rf /var/lib/apt/lists/*
> /root/.ssh/authorized_keys
shutdown -h now
