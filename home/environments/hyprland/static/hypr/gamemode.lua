local gamemode_binds = {}
local is_active = false
local gamemode_tag = "gamemode"
local enable_notif = true
local notif_time = 2000


-- TODO: Get list from file and add keybinds to automatically add games
-- Window class of games to enable gamemode for
GAMES = {
    "steam_app_311210", -- Bo3
    "steam_app_381210", -- DBD
    "dota2", -- Dota 2
}

for _, game_class in ipairs(GAMES) do
    hl.window_rule({ match = { class = game_class }, tag = "+" .. gamemode_tag })
end

function GM_bind(bind, dsp, opt)
    table.insert(gamemode_binds, hl.bind(bind, dsp, opt))
end

local function set_binds_state(value)
    for _, bind in ipairs(gamemode_binds) do
        bind:set_enabled(value)
    end
end

function ToggleGamemode()
    if is_active then DisableGamemode() else EnableGamemode() end
end

function EnableGamemode()
    if is_active then return end
    is_active = true
    set_binds_state(false)
    if enable_notif then hl.notification.create({ text = "Gamemode ON", time = notif_time, icon = 1 }) end
end

function DisableGamemode()
    if not is_active then return end
    is_active = false
    set_binds_state(true)
    if enable_notif then hl.notification.create({ text = "Gamemode OFF", time = notif_time, icon = 1 }) end
end

function IsGamemodeActive()
    return is_active
end

function GetGamemodeTag()
    return gamemode_tag
end

hl.on("window.active", function (window)
    if window == nil or window.tags == nil then DisableGamemode() return end
    local found = false

    for _, tag in ipairs(window.tags) do
        if tag == gamemode_tag .. "*" then
            found = true
            break
        end
    end

    if found then
        EnableGamemode()
    else
        DisableGamemode()
    end
end)