echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/vda
sync
sleep 3
mkfs.ext4 /dev/vda1
sync
sleep 3
mount /dev/vda1 /mnt
echo -e "\n" | pacstrap -i /mnt bash linux grub pacman cloud-init openssh
sync 
sleep 3
genfstab -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash locale-gen
arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
arch-chroot /mnt grub-install --target=i386-pc --recheck /dev/vda
#sleep 600