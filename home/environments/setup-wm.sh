#!/bin/bash

echo "[Window Manager Setup] Setting up common elements..."

WALLPAPER=$HOME/Pictures/wallpapers/purple_stare.png

echo "[Window Manager Setup] Setting up wallpapers..."
if ! [[ -e $HOME/Pictures/wallpapers/wallpaper1 ]]; then
    ln -s $WALLPAPER $HOME/Pictures/wallpapers/wallpaper1
    ln -s $WALLPAPER $HOME/Pictures/wallpapers/wallpaper2
fi

ICONS_DIR=$HOME/.local/share/icons
TELA_ICONS=$ICONS_DIR/tela-icons.tar.gz

echo "[Window Manager Setup] Setting up icons..."
if ! [[ -e $TELA_ICONS ]]; then
    tar -zxf $TELA_ICONS -C $ICONS_DIR
    rm $TELA_ICONS
fi

echo "[Window Manager Setup] Setting up themes..."
gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-mauve-standard+default
gsettings set org.gnome.desktop.interface icon-theme Tela-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

read -p "Do you want to install/replace the SDDM theme config? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] then
echo "[Window Manager Setup] Setting up SDDM..."
sudo systemctl enable sddm.service
sudo mkdir -p /etc/sddm.conf.d/
sudo bash -c "echo \"[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
[Theme]
Current=catppuccin-mocha-mauve
Font=Noto Sans,10,-1,0,400,0,0,0,0,0,0,0,0,0,0,1\" > /etc/sddm.conf.d/theme.conf"
fi