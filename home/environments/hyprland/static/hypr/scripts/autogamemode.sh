#!/bin/sh

check_tags() {
    case $1 in
        *gamemode*) hyprctl -q dispatch submap gamemode;;
        *) hyprctl -q dispatch submap reset ;;
    esac
}

handle() {
    case $1 in
        activewindow\>\>*)
            local tags=$(hyprctl activewindow | grep tags:)
            check_tags "$tags"
        ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
