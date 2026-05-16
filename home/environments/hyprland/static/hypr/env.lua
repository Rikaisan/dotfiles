-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("GRIMBLAST_EDITOR", "swappy -f")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("BROWSER", "zen-browser")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("JAVA_HOME", "/usr/lib/jvm/default-runtime")
