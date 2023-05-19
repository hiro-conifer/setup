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

#pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware
