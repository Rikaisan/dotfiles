-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require("env")
require("visuals")
require("globals")
require("workspaces")
require("keymap")
require("rules")
require("input")
require("autostart")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
if MACHINE == "desktop" then
    hl.monitor({ output = "DP-1", mode ="1920x1080@144", position= "0x0", scale = "1" } )
    hl.monitor({ output = "HDMI-A-1", mode ="1920x1080@60", position= "1920x0", scale = "1" } )

    -- Refresh Rate Swappers
    hl.bind("SUPER + F1", function ()
        if MACHINE == "desktop" then
            hl.monitor({ output = "DP-1", mode ="1920x1080@144", position= "0x0", scale = "1" } )
        end
    end)

    hl.bind("SUPER + F2", function ()
        if MACHINE == "desktop" then
            hl.monitor({ output = "DP-1", mode ="1920x1080@60", position= "0x0", scale = "1" } )
        end
    end)
elseif MACHINE == "laptop" then
    hl.monitor({ output = "eDP-1", mode ="1920x1080@60", position= "0x0", scale = "1" } )
end
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        initial_workspace_tracking = 0,
    },
})

hl.config({
    binds = {
        workspace_center_on = 1,
    }
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
