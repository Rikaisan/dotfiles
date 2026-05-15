---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Game Mode

require("gamemode")
hl.bind(mainMod .. " + G",  ToggleGamemode)

-- End Game Mode

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- Apps
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(TERMINAL))
GM_bind(mainMod .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))
GM_bind(mainMod .. " + D", hl.dsp.exec_cmd(MENU))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(EMOJI_MENU))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(NOTIFICATIONS))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(PAINT))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(LOCK))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(LOGOUT))

-- Custom Scripts
GM_bind(mainMod .. " + B", ReloadBar)
GM_bind(mainMod .. " + W", ReloadWallpapers)
hl.bind(mainMod .. " + P", PinFocus)

-- Control
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + K", hl.dsp.window.kill())
hl.bind(mainMod .. " + ALT + SHIFT + delete", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + J", hl.dsp.layout("rotatesplit"))
GM_bind(mainMod .. " + C", hl.dsp.window.center())
GM_bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))

-- Debug
hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + ALT + SHIFT + W", hl.dsp.exec_cmd("hyprctl activewindow > ~/.config/hypr/activewindow"))

-- Clipboard
GM_bind(mainMod.. " + SHIFT + C", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

hl.bind("print", ExecWithNotif("grimblast --freeze copy area", "Screenshot copied!", 5000, 5))
hl.bind("ALT + print", ExecWithNotif("grimblast --freeze save area", "Screenshot saved!", 5000, 5))
hl.bind("CTRL + print", hl.dsp.exec_cmd("grimblast --freeze edit area"))
hl.bind("CTRL + SHIFT + print", hl.dsp.exec_cmd("grimblast --freeze edit output"))
hl.bind("SHIFT + print", ExecWithNotif("grimblast --freeze copy output", "Screenshot copied!", 5000, 5))
hl.bind("ALT + SHIFT + print", ExecWithNotif("grimblast --freeze save output", "Screenshot saved!", 5000, 5))

-- Move focus with mainMod + arrow keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.swap({ direction = dir }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, function ()
        if hl.get_active_monitor().id == 1 then
            hl.dispatch(hl.dsp.focus({ workspace = i + 10 }))
        else
            hl.dispatch(hl.dsp.focus({ workspace = i }))
        end
    end)

    hl.bind(mainMod .. " + SHIFT + " .. key, function ()
        if hl.get_active_monitor().id == 1 then
            hl.dispatch(hl.dsp.window.move({ workspace = i + 10 }))
        else
            hl.dispatch(hl.dsp.window.move({ workspace = i }))
        end
    end)
end

hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + ALT + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + ALT + CTRL + left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "left" }))

-- Special Workspaces
local special_workspaces = {
    ["special"] = "S",
    ["term"] = "BACKSLASH",
    ["term2"] = "QUOTELEFT",
}

for name, key in pairs(special_workspaces) do
    GM_bind(mainMod .. " + " .. key, hl.dsp.workspace.toggle_special(name))
    GM_bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "special:" .. name }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
-- Default Binds
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
-- hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
-- Scripted Binds
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(VOLUME_SCRIPT .. " --inc"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(VOLUME_SCRIPT .. " --dec"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(VOLUME_SCRIPT .. " --toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(VOLUME_SCRIPT .. " --toggle-mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd(BRIGHTNESS_SCRIPT .. " --inc"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd(BRIGHTNESS_SCRIPT .. " --dec"),    { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

GM_bind(mainMod .. " + R", function ()
    hl.dispatch(hl.dsp.submap("resize"))
    hl.notification.create({ text = "Entered manipulation mode, use ESC to exit", time = 3000, icon = 2 })
end)

hl.define_submap("resize", function ()
    local steps = {
        { "SHIFT + ", 10 },
        { "", 100 },
        { "CTRL + ", 200 }
    }

    for _, step in ipairs(steps) do
        -- Movement
        hl.bind(step[1] .. "right", hl.dsp.window.move({ x = step[2],          y = 0,         relative = true }), { repeating = true })
        hl.bind(step[1] .. "left",  hl.dsp.window.move({ x = -step[2],         y = 0,         relative = true }), { repeating = true })
        hl.bind(step[1] .. "up",    hl.dsp.window.move({ x = 0,                y = -step[2],  relative = true }), { repeating = true })
        hl.bind(step[1] .. "down",  hl.dsp.window.move({ x = 0,                y = step[2],   relative = true }), { repeating = true })

        -- Resizing
        hl.bind(step[1] .. "ALT + right", hl.dsp.window.resize({ x = step[2],  y = 0,         relative = true }), { repeating = true })
        hl.bind(step[1] .. "ALT + left",  hl.dsp.window.resize({ x = -step[2], y = 0,         relative = true }), { repeating = true })
        hl.bind(step[1] .. "ALT + up",    hl.dsp.window.resize({ x = 0,        y = -step[2],  relative = true }), { repeating = true })
        hl.bind(step[1] .. "ALT + down",  hl.dsp.window.resize({ x = 0,        y = step[2],   relative = true }), { repeating = true })
    end

    -- Extra binds
    hl.bind("C", hl.dsp.window.center())
    hl.bind("R", hl.dsp.window.resize({ x = hl.get_active_monitor().width / 2, y = hl.get_active_monitor().height / 2 }))
    hl.bind("V", function()
        hl.dispatch(hl.dsp.window.resize({ x = hl.get_active_monitor().width / 2, y = hl.get_active_monitor().height / 2 }))
        hl.dispatch(hl.dsp.window.center())
    end)

    hl.bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind("mouse:273", hl.dsp.window.resize(), { mouse = true })


    -- use to go back to the global submap
    local function exit_resize()
        hl.dispatch(hl.dsp.submap("reset"))
        hl.notification.create({ text = "Exited manipulation mode", time = 3000, icon = 2 })
    end

    hl.bind("escape", exit_resize)
    hl.bind("return", exit_resize)
    hl.bind("Q", exit_resize)
end)
