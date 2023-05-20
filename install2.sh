#!/bin/sh
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

echo ja_JP.UTF-8 UTF-8 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=jp106 > /etc/vconsole.conf

echo TYPE_HOSTNAME:
read hostnm
echo ${hostnm} > /etc/hostname
echo 127.0.0.1 localhost > /etc/hosts
echo ::1 localhost >> /etc/hosts
echo 127.0.1.1 ${hostnm}.localdomain ${hostnm} >> /etc/hosts

pacman -S --noconfirm booster networkmanager
bootctl install

echo default arch.conf > /boot/loader/loader.conf
echo console-mode max >> /boot/loader/loader.conf
echo editor no >> /boot/loader/loader.conf

echo title Arch Linux >> /boot/loader/entries/arch.conf
echo linux /vmlinuz-linux-zen >> /boot/loader/entries/arch.conf
echo initrd /booster-linux-zen.img >> /boot/loader/entries/arch.conf
echo options root=`blkid -o export /dev/sdb3 | grep ^PARTUUID` rw >> /boot/loader/entries/arch.conf

systemctl enable NetworkManager.service
systemctl enable fstrim.timer
