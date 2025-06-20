if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    read -p "Do you want to setup Hyprland plugins now? (Make sure you are logged in into Hyprland) [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] then
        echo "[CHEZMOI] Setting up Hyprland plugins..."
        hyprpm update
        hyprpm add https://github.com/shezdy/hyprsplit # Add the plugin repository
        hyprpm enable hyprsplit # Enable the plugin
        hyprpm reload # Reload the plugins

        # Remove autoexecute
        echo "[CHEZMOI] Cleaning up..."
        sed -i "s/bash ~\/.config\/hypr\/scripts\/post_install.sh//" ~/.zshrc
        rm ~/.config/hypr/scripts/post_install.sh
        echo "[CHEZMOI] Done!"
    fi
fi