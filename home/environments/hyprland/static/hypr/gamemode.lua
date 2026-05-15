local gamemode_binds = {}
local is_active = false
local gamemode_tag = "gamemode"


-- TODO: Get list from file and add keybinds to automatically add games
-- Window class of games to enable gamemode for
GAMES = {
    "steam_app_311210",
    "steam_app_381210",
    "dota2",
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
    is_active = not is_active
    set_binds_state(not is_active)
    hl.notification.create({ text = "Gamemode " .. (is_active and "ON" or "OFF"), time = 3000, icon = 1 })
end

function EnableGamemode()
    is_active = true
    set_binds_state(false)
    hl.notification.create({ text = "Gamemode ON", time = 3000, icon = 1 })
end

function DisableGamemode()
    is_active = false
    set_binds_state(true)
    hl.notification.create({ text = "Gamemode OFF", time = 3000, icon = 1 })
end

function IsGamemodeActive()
    return is_active
end

function GetGamemodeTag()
    return gamemode_tag
end

hl.on("window.active", function (window)
    local found = false

    for _, tag in ipairs(window.tags) do
        if tag == gamemode_tag then
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