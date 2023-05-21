#!/bin/sh
ln -sf ~/dotfiles/.config ~/.config
ln -sf ~/dotfiles/.local ~/.local
ln -sf ~/dotfiles/.xprofile ~/.xprofile

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo pacman -S --noconfirm xorg-xwayland qt5-wayland
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo pacman -S --noconfirm sway swaylock-fancy swayidle swaybg waybar mako
