ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

sed -i '/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sed -i '/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=jp106 > /etc/vconsole.conf

hostnm=hiropc
echo '${hostnm}' > /etc/hostname
echo '127.0.0.1 localhost' > /etc/hosts
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 ${hostnm}.localdomain ${hostnm}' >> /etc/hosts
