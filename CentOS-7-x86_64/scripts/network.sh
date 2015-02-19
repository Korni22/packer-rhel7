echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo 'NM_CONTORLLED="no"' >> /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl disable iptables
systemctl disable firewalld