require("globals")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
    hl.exec_cmd(POLKIT)
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprcursor")
    hl.exec_cmd("waybar")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("syncthing serve --no-browser")
    hl.exec_cmd("swaync")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data

    if MACHINE == "desktop" then
        hl.exec_cmd("keepassxc")
        hl.exec_cmd("openrgb --startminimized --profile \"Purple\"")
        hl.exec_cmd("com.github.wwmm.easyeffects")
    else
        hl.exec_cmd("keepassxc")
    end
end)

