# echo "# ttyS0 - getty
# #
# # This service maintains a getty on ttyS0 from the point the system is
# # started until it is shut down again.

# start on stopped rc RUNLEVEL=[12345]
# stop on runlevel [!12345]

# respawn
# exec /sbin/getty -L 115200 ttyS0 vt102" > /tmp/bootlogs.sh

# cat /tmp/bootlogs.sh | sudo tee /etc/init/ttyS0.conf

# echo packer | sudo -S start ttyS0