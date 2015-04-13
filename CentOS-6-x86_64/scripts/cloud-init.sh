rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y cloud-init cloud-utils-growpart cloud-utils

sed -i 's/.*PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config

sed -i 's/disable_root: 1/disable_root: 0/' /etc/cloud/cloud.cfg
