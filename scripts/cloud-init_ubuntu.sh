#echo packer | sudo -S sed -i s/us/de/g /etc/apt/sources.list
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get install -y cloud-init
sed -i 's/^\s*disable_root:\s.*/disable_root: 0/' /etc/cloud/cloud.cfg;\
