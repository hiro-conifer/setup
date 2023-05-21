#!/bin/sh
ln -sf ~/dotfiles/.config ~/.config
ln -sf ~/dotfiles/.local ~/.local
ln -sf ~/dotfiles/.xprofile ~/.xprofile

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

yay -S --noconfirm xorg-xwayland qt5-wayland

yay -S --noconfirm lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-reactive
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i '/debug_mode          = false/s/false/true/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo sed -i '/webkit_theme        = antergos/s/antergos/reactive/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm

yay -S --noconfirm swayfx swaylock-fancy swayidle swaybg waybar mako
sudo cp ~/dotfiles/sway.sh /usr/local/bin/
sudo chmod 755 /usr/local/bin/sway.sh
sudo cp ~/dotfiles/sway.desktop /usr/share/wayland-sessions/
