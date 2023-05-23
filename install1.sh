#!/bin/sh
echo Type Target Partition:
read tgt_part
lsblk | grep ${tgt_part}
if [ $? != 0 ]; then
  echo 'not found disk.'
  exit
fi
tgt_disk=/dev/${tgt_part}
echo ${tgt_part} > target_part

timedatectl set-ntp true
timedatectl status

sgdisk -Z ${tgt_part}
sgdisk -o ${tgt_part}
sgdisk -n 1:0:+300M -t 1:ef00 ${tgt_part}
sgdisk -n 2:0:+512M -t 2:8200 ${tgt_part}
sgdisk -n 3:0: -t 3:8304 ${tgt_part}


mkfs.vfat -F 32 ${tgt_part}1
mkswap ${tgt_part}2
mkfs.ext4 -F ${tgt_part}3

mount ${tgt_part}3 /mnt
swapon ${tgt_part}2
mount --mkdir ${tgt_part}1 /mnt/boot

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware git neovim

genfstab -U /mnt >> /mnt/etc/fstab
cp -r /root/setup /mnt/
arch-chroot /mnt
