rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -i https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install -y cloud-init cloud-utils-growpart cloud-utils

sed -i 's/disable_root: 1/disable_root: 0/' /etc/cloud/cloud.cfg
