#!/bin/bash

tgt_disk=/dev/sdb
sgdisk -Z ${tgt_disk}
sgdisk -o ${tgt_disk}
sgdisk -n 1:0:+512M -t 1:ef00 ${tgt_disk}
sgdisk -n 2:0:+300M -t 2:8200 ${tgt_disk}
sgdisk -n 3:0: -t 3:8304 ${tgt_disk}

mkfs.vfat -F 32 ${tgt_disk}1
mkswap ${tgt_disk}2
mkfs.ext4 -F ${tgt_disk}3

mount ${tgt_disk}3 /mnt
mount --mkdir ${tgt_disk}1 /mnt/boot
swapon ${tgt_disk}2

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

sed -i '/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sed -i '/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=jp106 > /etc/vconsole.conf

hostnm=hiropc
echo ${hostnm} > /etc/hostname
echo 127.0.0.1 localhost > /etc/hosts
::1 localhost >> /etc/hosts
127.0.1.1 ${hostnm}.localdomain ${hostnm} >> /etc/hosts

