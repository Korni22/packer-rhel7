# Clean up unneeded packages.
echo "apt-get -y autoremove" > /tmp/script.sh
echo "apt-get -y clean" >> /tmp/script.sh
echo packer | sudo -S -u root -H sh -c "sh /tmp/script.sh"

# Ensure that udev doesn't screw us with network device naming.
# ln -sf /dev/null /lib/udev/rules.d/75-persistent-net-generator.rules
# rm -f /etc/udev/rules.d/70-persistent-net.rules

# # On startup, remove HWADDR and uuid from the eth0 interface.
# cp -f /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/eth0
# sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-eth0
# sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0

# # Disable the zeroconf route
# echo "NOZEROCONF=yes" >> /etc/sysconfig/network
# echo "PERSISTENT_DHCLIENT=yes" >> /etc/sysconfig/network

# # support second network card
# cp /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth1
# sed -i 's/eth0/eth1/' /etc/sysconfig/network-scripts/ifcfg-eth1

# # remove password from root
# # passwd -d root

# # remove sd* specific UUIDs
# #sed -i '/UUID/d' /etc/fstab

# # remove unneeded languages
# #localedef --list-archive | grep -v -e "en_US" | xargs localedef --delete-from-archive
# #mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
# #build-locale-archive


# cat <<EOF_ifcfg >/etc/sysconfig/network-scripts/ifcfg-eth0
# NAME="eth0"
# ONBOOT=yes
# IPV6INIT=yes
# BOOTPROTO=dhcp
# TYPE=Ethernet
# DEVICE="eth0"
# NM_controlled="no"
# PERSISTENT_DHCLIENT=1
# DEFROUTE=yes
# EOF_ifcfg
#yum -C -y remove NetworkManager --setopt="clean_requirements_on_remove=1"