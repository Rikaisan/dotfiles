#!/bin/bash

# Rebuild bat cache
if command -v bat &> /dev/null
then
    echo "[SETUP] Rebuilding Bat cache..."
    bat cache --build
fi

# Update tealdeer db
if command -v tldr &> /dev/null
then
    echo "[SETUP] Fetching tldr DB..."
    tldr --update
fi

# Enable Bluetooth
if command -v bluetoothctl &> /dev/null
then
    echo "[SETUP] Setting up Bluetooth..."
    sudo systemctl enable bluetooth --now
fi

# Install Rust
if command -v rustup &> /dev/null
then
    echo "[SETUP] Setting up Rust..."
    rustup default stable
fi

# Enable UFW
if command -v ufw &> /dev/null
then
    echo "[SETUP] Setting up UFW..."
    sudo ufw enable
    sudo systemctl enable ufw
fi

# Setup no-root docker
if command -v docker &> /dev/null
then
    echo "[SETUP] Configuring Docker..."
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo systemctl enable docker --now
fi


read -p "[SETUP] Do you want to setup KVM/QEMU for virtualization?[y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo pacman -S --needed qemu-base virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables-nft libguestfs

    sudo sed -i "s/#unix_sock_group/unix_sock_group/" /etc/libvirt/libvirtd.conf
    sudo sed -i "s/#unix_sock_rw_perms/unix_sock_rw_perms/" /etc/libvirt/libvirtd.conf

    sudo usermod -aG libvirt $USER

    sudo systemctl enable libvirtd.socket --now
fi

read -p "[SETUP] Do you want to run nvidia-inst?[y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "[SETUP] Setting up NVIDIA..."
    nvidia-inst
fi

if command -v envycontrol &> /dev/null
then
    read -p "[SETUP] Do you want to change envycontrol mode to nvidia?[y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "[SETUP] Switching up to NVIDIA..."
        sudo envycontrol -s nvidia
    fi
fi

echo "[SETUP] Instalation finished! It's recommended that you reboot your machine now to complete the installation."
