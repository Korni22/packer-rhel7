mkdir -p /etc/local/runonce.d/ran

cat > /usr/local/bin/runonce <<EOF
#!/bin/sh
for file in /etc/local/runonce.d/*
do
    if [ ! -f "$file" ]
    then
        continue
    fi
    "$file"
    mv "$file" "/etc/local/runonce.d/ran/$file.$(date +%Y%m%dT%H%M%S)"
    logger -t runonce -p local3.info "$file"
done
EOF

chmod +x /usr/local/bin/runonce

cat > /etc/local/runonce.d/growpart << EOF
sleep 3
mount -o rw,remount /
sleep 3
growpart /dev/vda 1 -v
sleep 3
partprobe
sleep 3
xfs_growfs /
EOF

chown root:root /etc/local/runonce.d/growpart

chmod +x /etc/local/runonce.d/growpart

cat > /etc/cron << EOF
@reboot /usr/local/bin/runonce
EOF