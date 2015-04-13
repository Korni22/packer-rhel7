# Clean up unneeded packages.
yum -y clean all

# Ensure that udev doesn't screw us with network device naming.
ln -sf /dev/null /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules

# On startup, remove HWADDR and uuid from the eth0 interface.
cp -f /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/eth0
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0

# Disable the zeroconf route
echo "NOZEROCONF=yes" >> /etc/sysconfig/network
echo "PERSISTENT_DHCLIENT=yes" >> /etc/sysconfig/network

# support second network card
cp /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth1
sed -i 's/eth0/eth1/' /etc/sysconfig/network-scripts/ifcfg-eth1

# remove password from root
# passwd -d root

# remove sd* specific UUIDs
#sed -i '/UUID/d' /etc/fstab

# remove unneeded languages
localedef --list-archive | grep -v -e "en_US" | xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
