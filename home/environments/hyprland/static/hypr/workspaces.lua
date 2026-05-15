require("globals")

for i = 1,10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = MACHINE == "desktop" and "DP-1" or "eDP-1", default = i == 1 })
    hl.workspace_rule({ workspace = tostring(i + 10), monitor = "HDMI-A-1", default = i == 1 })
end

hl.window_rule({ match = { class = "steam" },                       workspace = "3"  })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" },     workspace = MACHINE == "desktop" and "19 silent" or "9 silent"  })
hl.window_rule({ match = { class = "carla" },                       workspace = MACHINE == "desktop" and "18 silent" or "8 silent"  })
hl.window_rule({ match = { class = "com.github.wwmm.easyeffects" }, workspace = MACHINE == "desktop" and "18 silent" or "8 silent"  })
hl.window_rule({ match = { class = "org.qbittorrent.qBittorrent" }, workspace = MACHINE == "desktop" and "20 silent" or "10 silent" })
