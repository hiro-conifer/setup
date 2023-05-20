#!/bin/sh
echo Type Target Disk:
read tgt_disk
lsblk | grep ${tgt_disk}
if [ $? != 0 ]; then
  echo 'not found disk.'
  exit
fi
tgt_disk=/dev/${tgt_disk}
echo ${tgt_disk} > target_disk

sgdisk -Z ${tgt_disk}
sgdisk -o ${tgt_disk}
sgdisk -n 1:0:+512M -t 1:ef00 ${tgt_disk}
sgdisk -n 2:0:+300M -t 2:8200 ${tgt_disk}
sgdisk -n 3:0: -t 3:8304 ${tgt_disk}

mkfs.vfat -F 32 ${tgt_disk}1
mkswap ${tgt_disk}2
mkfs.ext4 -F ${tgt_disk}3

mount ${tgt_disk}3 /mnt
swapon ${tgt_disk}2
mount --mkdir ${tgt_disk}1 /mnt/boot

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware git vim

genfstab -U /mnt >> /mnt/etc/fstab
cp -r /root/setup /mnt/
arch-chroot /mnt
