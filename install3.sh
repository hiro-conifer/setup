#!/bin/sh
ln -sf ~/dotfiles/.config ~/.config
ln -sf ~/dotfiles/.local ~/.local
ln -sf ~/dotfiles/.xprofile ~/.xprofile

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

yay -S --noconfirm xorg-xwayland qt5-wayland
yay -S --noconfirm lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-reactive
yay -S --noconfirm swayfx swaylock-fancy swayidle swaybg waybar mako
