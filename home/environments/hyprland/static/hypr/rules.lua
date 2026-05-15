--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "^(wofi)$" }, float = true })

-- Browser
hl.window_rule({ match = { class = "firefox" }, tag = "+opaque" })
hl.window_rule({ match = { class = "vivaldi-stable" }, tag = "+opaque" })
hl.window_rule({ match = { class = "zen" }, tag = "+opaque" })

-- Godot
hl.window_rule({ match = { class = "Godot" }, tag = "+opaque" })
hl.window_rule({ match = { class = "Godot", title = "^(.*Settings.*)$" }, tag = "+centerfloat" })
hl.window_rule({ match = { class = "Godot", title = "^(Create New Node)$" }, tag = "+centerfloat" })

-- VSCode
hl.window_rule({ match = { class = "^(Code)$" }, opacity = "0.95" })

-- Discord
hl.window_rule({ match = { class = "discord" }, opacity = "0.95" })

-- Menu
hl.window_rule({ match = { class = "^(wofi)$" }, opacity = "0.95" })

-- pico8
hl.window_rule({ match = { class = "pico8" }, float = true, center = true, size = { 512, 512 }, keep_aspect_ratio = true, nearest_neighbor = true })

-- Auth
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
hl.window_rule({ match = { class = "^(org.gnome.polkit-gnome-authentication-agent-1)$" }, float = true })

-- External panels
hl.window_rule({ match = { class = "(nm-connection-editor)" }, float = true })

-- qBittorrent
hl.window_rule({ match = { class = "org.qbittorrent.qBittorrent" }, tag = "+torrents" })
hl.window_rule({ match = { title = "^(qBittorrent).*", tag = "torrents" }, tag = "+prevent_float" }) -- Main window

-- Window sizes
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true, center = true, size = { 360, 540 } })

-- Apps that should float and be centered
hl.window_rule({ match = { class = "^(blender)$", title = "^(File Browser)$" }, tag = "+centerfloat" })
hl.window_rule({ match = { class = "^(kitty)$" }, tag = "+centerfloat" })
hl.window_rule({ match = { tag = "torrents" }, tag = "+centerfloat" })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, tag = "+floating" })

hl.window_rule({ match = { tag = "prevent_float" }, tag = "-float" })
hl.window_rule({ match = { tag = "prevent_float" }, tag = "-centerfloat" })
hl.window_rule({ match = { tag = "centerfloat" }, float = true, center = true, size = { "monitor_w/2", "monitor_h/2" } })
hl.window_rule({ match = { tag = "floating" }, float = true, center = true })

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Media Players
hl.window_rule({ match = { class = "vlc" }, tag = "+opaque" })
hl.window_rule({ match = { class = "mpv" }, tag = "+opaque" })
hl.window_rule({ match = { fullscreen = true }, tag = "+opaque" })

-- Opaque
hl.window_rule({ match = { tag = "opaque" }, opaque = true, no_dim = true })

-- Hidden
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, no_screen_share = true })

-- Steam Rules
hl.window_rule({ match = { class = "steam" }, no_initial_focus = true, suppress_event = "activate activatefocus" })

--------------------
---- WORKSPACES ----
--------------------

-- Rules related to workspaces are in the workspaces module