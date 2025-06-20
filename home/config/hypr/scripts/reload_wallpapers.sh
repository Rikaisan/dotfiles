WP1=$HOME/Pictures/wallpapers/wallpaper1
WP2=$HOME/Pictures/wallpapers/wallpaper1

hyprctl hyprpaper unload all
hyprctl hyprpaper preload $WP1
#~desktop
hyprctl hyprpaper preload $WP2
hyprctl hyprpaper wallpaper "DP-1,$WP1"
hyprctl hyprpaper wallpaper "HDMI-A-1,$WP2"
#~end-desktop
#~laptop
hyprctl hyprpaper wallpaper "eDP-1,$WP1"
#~end-laptop

hyprctl notify 5 5000 0 "Reloaded wallpapers!"