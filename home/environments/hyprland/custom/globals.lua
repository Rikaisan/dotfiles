---------------------
---- ENVIRONMENT ----
---------------------

--~desktop
MACHINE = "desktop"
--~end-desktop
--~laptop
MACHINE = "laptop"
--~end-laptop
--~en
KB_LANG = "en"
--~end-en
--~es
KB_LANG = "es"
--~end-es

WP_DIR = os.getenv("HOME") .. "/Pictures/wallpapers/"
WP1 = WP_DIR .. "wallpaper1"
WP2 = WP_DIR .. "wallpaper2"

---------------------
---- MY PROGRAMS ----
---------------------

POLKIT = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
TERMINAL = "kitty"
FILE_MANAGER = "thunar"
MENU = "wofi --show drun"
EMOJI_MENU = "wofi-emoji"
NOTIFICATIONS = "swaync-client -t -sw"
LOCK = "hyprlock"
LOGOUT = "wlogout"
VOLUME_SCRIPT = "~/.local/bin/rikai/volume.sh"
BRIGHTNESS_SCRIPT = "~/.local/bin/rikai/brightness.sh"
PAINT = "wayscriber --active"

--------------------
---- MY SCRIPTS ----
--------------------

-- os.execute is not async
function ReloadBar()
    os.execute("killall waybar")
    hl.exec_cmd("waybar")
end

function ReloadWallpapers()
    os.execute("hyprctl hyprpaper unload all")
    os.execute("hyprctl hyprpaper preload \"" .. WP1 .. "\"")

    if MACHINE == "desktop" then
        os.execute("hyprctl hyprpaper preload \"" .. WP2 .. "\"")
        os.execute("hyprctl hyprpaper wallpaper \"DP-1," .. WP1 .. "\"")
        os.execute("hyprctl hyprpaper wallpaper \"HDMI-A-1," .. WP2 .. "\"")
    else
        os.execute("hyprctl hyprpaper wallpaper \"eDP-1," .. WP1 .. "\"")
    end

    hl.notification.create({ text = "Reloaded wallpapers!", time = 3000, icon = 5 })
end

function PinFocus()
    if hl.get_config("input.follow_mouse") == 0 then
        hl.config({ input = { follow_mouse = 1, float_switch_override_focus = 1 } })
        hl.notification.create({ text = "Follow Mouse ON", time = 3000, icon = 2 })
    else
        hl.config({ input = { follow_mouse = 0, float_switch_override_focus = 0 } })
        hl.notification.create({ text = "Follow Mouse OFF", time = 3000, icon = 2 })
    end
end

function ExecWithNotif(cmd, msg, notif_time, notif_icon)
    return function ()
        hl.exec_cmd(cmd .. "&& hyprctl notify " .. notif_icon .. " " .. notif_time .. " 0 \"" .. msg .. "\"")
    end
end