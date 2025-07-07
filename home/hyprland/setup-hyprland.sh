#!/bin/bash

echo "[HYPRLAND] Setting up Hyprland..."

WALLPAPER=$HOME/Pictures/wallpapers/purple_stare.png

echo "[HYPRLAND] Setting up Hyprland wallpapers..."
if ! [[ -e $HOME/Pictures/wallpapers/wallpaper1 ]]; then
    ln -s $WALLPAPER $HOME/Pictures/wallpapers/wallpaper1
    ln -s $WALLPAPER $HOME/Pictures/wallpapers/wallpaper2
fi

echo "[HYPRLAND] Setting up Theme..."
gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-mauve-standard+default
gsettings set org.gnome.desktop.interface icon-theme Tela-dark

read -p "Do you want to install/replace the SDDM theme config? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] then
echo "[HYPRLAND] Setting up SDDM..."
sudo systemctl enable sddm.service
sudo mkdir -p /etc/sddm.conf.d/
sudo bash -c "echo \"[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
[Theme]
Current=catppuccin-mocha
Font=Noto Sans,10,-1,0,400,0,0,0,0,0,0,0,0,0,0,1\" > /etc/sddm.conf.d/theme.conf"
fi