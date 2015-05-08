cat <<EOF_ifcfg >/etc/sysconfig/network-scripts/ifcfg-eth0
NAME="eth0"
ONBOOT=yes
IPV6INIT=yes
BOOTPROTO=dhcp
TYPE=Ethernet
DEVICE="eth0"
NM_controlled="no"
PERSISTENT_DHCLIENT=1
DEFROUTE=yes
EOF_ifcfg
yum -C -y remove NetworkManager --setopt="clean_requirements_on_remove=1"