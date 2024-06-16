#!/bin/bash

FILE=~/.config/hypr/modules/input.conf
CURRENT_STATUS=$(cat $FILE | grep follow_mouse | awk '{print $3}')

case $CURRENT_STATUS in
    0)
    sed -i 's/follow_mouse = 0/follow_mouse = 1/' $FILE
    hyprctl notify 2 3000 0 "Follow Mouse ON"
    ;;
    1)
    sed -i 's/follow_mouse = 1/follow_mouse = 0/' $FILE
    hyprctl notify 2 3000 0 "Follow Mouse OFF"
    ;;
esac
