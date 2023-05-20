#!/bin/sh
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

echo ja_JP.UTF-8 UTF-8 >> /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=jp106 > /etc/vconsole.conf

echo Type Hostname:
read hostnm
echo ${hostnm} > /etc/hostname
echo 127.0.0.1 localhost > /etc/hosts
echo ::1 localhost >> /etc/hosts
echo 127.0.1.1 ${hostnm}.localdomain ${hostnm} >> /etc/hosts

pacman -S --noconfirm booster networkmanager vim
bootctl install

echo default arch.conf > /boot/loader/loader.conf
echo console-mode max >> /boot/loader/loader.conf
echo editor no >> /boot/loader/loader.conf

echo title Arch Linux >> /boot/loader/entries/arch.conf
echo linux /vmlinuz-linux-zen >> /boot/loader/entries/arch.conf
lscpu | grep 'Model name' | grep 'Intel'
if [ $? = 0 ]; then
  pacman -S --noconfirm intel-ucode
  echo initrd /intel-ucode.img >> /boot/loader/entries/arch.conf
fi
lscpu | grep 'Model name' | grep 'AMD'
if [ $? = 0 ]; then
  pacman -S --noconfirm amd-ucode
  echo initrd /amd-ucode.img >> /boot/loader/entries/arch.conf
fi
echo initrd /booster-linux-zen.img >> /boot/loader/entries/arch.conf
echo options root=`blkid -o export /dev/sdb3 | grep ^PARTUUID` rw >> /boot/loader/entries/arch.conf

systemctl enable NetworkManager.service
systemctl enable fstrim.timer

clear
echo Type root password:
read rootpw
echo root:$rootpw | chpasswd

clear
echo Type Username:
read usernm
useradd -m -G wheel $usernm
echo Type Userpassword:
read userpw
echo $usernm:$userpw | chpasswd

sed -i /'# %wheel ALL=(ALL:ALL) ALL'/'%wheel ALL=(ALL:ALL) ALL'/ /etc/sudoers
