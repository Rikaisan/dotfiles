echo "[PACKAGES] Updating the keyring..."
sudo pacman -Sy --needed archlinux-keyring
# Install Git and Yay
if ! command -v yay &> /dev/null
then
    if ! command -v git &> /dev/null
    then
        echo "[PACKAGES] git could not be found, installing..."
        sudo pacman -Sy --needed --noconfirm git
    fi
    echo "[PACKAGES] yay could not be found, installing..."
    cd $(mktemp -d)
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sic
    cd ~
fi

# Some default yay configs for ease of use
if [ ! -f $HOME/.config/yay/config.json ]; then
    echo "[PACKAGES] '$HOME/.config/yay/config.json' not found, configuring yay..."
    yay --save --answerdiff None --answerclean None --removemake
fi