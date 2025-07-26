echo "[PACKAGES] Updating the keyring..."
sudo pacman -Sy --needed archlinux-keyring
# Install Git and Paru
if ! command -v paru &> /dev/null
then
    if ! command -v git &> /dev/null
    then
        echo "[PACKAGES] git could not be found, installing..."
        sudo pacman -Sy --needed --noconfirm git
    fi
    echo "[PACKAGES] paru could not be found, installing..."
    cd $(mktemp -d)
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -sic
    cd ~
fi