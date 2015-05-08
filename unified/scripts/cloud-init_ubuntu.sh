#echo packer | sudo -S sed -i s/us/de/g /etc/apt/sources.list
echo packer | sudo -S apt-get update
echo packer | sudo -S apt-get -y upgrade
echo packer | sudo -S apt-get -y dist-upgrade
echo packer | sudo -S apt-get install -y cloud-init
echo "sed -i 's|[#]*PermitRootLogin no|PermitRootLogin yes|g' /etc/ssh/sshd_config" > /tmp/cloud-init.sh
echo "sed -i 's|[#]*PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config" >> /tmp/cloud-init.sh

echo packer | sudo -S sh /tmp/cloud-init.sh