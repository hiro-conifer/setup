#!/bin/sh
ln -sf ~/dotfiles/.config ~/.config
ln -sf ~/dotfiles/.local ~/.local

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

yay -S --noconfirm xorg-xwayland qt5-wayland

yay -S --noconfirm lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-aether
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i '/debug_mode          = false/s/false/true/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm

yay -S --noconfirm swayfx swaylock-fancy swayidle swaybg waybar mako
sudo mv ~/dotfiles/sway.sh /usr/local/bin/
sudo chmod 755 /usr/local/bin/sway.sh
sudo mv ~/dotfiles/sway.desktop /usr/share/wayland-sessions/

yay -S thunar
rm -rf ~/dotfiles/yay
