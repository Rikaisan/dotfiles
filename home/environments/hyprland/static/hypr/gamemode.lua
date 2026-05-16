-------------------
-- HYPR GAMEMODE --
-------------------
-- Author: Rikai (https://github.com/Rikaisan)

-- This is a script to automatically enable/disable certain keybinds while gaming,
-- it's designed to be as drag-n-drop as possible, it can also be used to simply toggle
-- a group of binds when focusing a window or by pressing a keybind

-- Usage:
-- 1. Include the module in your keybind config file and give it a name: `local gm = require("gamemode")`
-- 2. Replace the root object of your desired binds with your chosen name: `hl` -> `gm`
-- 3. Add one game window class per line to <hypr_config_dir>/<games_file>, by default ~/.config/hypr/gamemode_games.txt
-- 4. Optionally create some keybinds to toggle game mode, tag/untag windows, automatically add games to this file or to manually refresh the game list

-- Minimal Example:
-- local gm = require("gamemode")
-- gm.bind(mainMod .. " + D", hl.dsp.exec_cmd(MENU)) -- Replaced the bind `hl` with `gm`, therefore now this bind will be managed by hyprgamemode

-- Helpful binds (Notice this are managed by Hyprland!):
-- hl.bind(mainMod .. " + G",  gm.toggle) -- Enable/Disable gamemode
-- hl.bind(mainMod .. " + SHIFT + G",  gm.add_focused_game) -- Adds the focused window to the permanent list of games
-- hl.bind(mainMod .. " + ALT + G",  gm.tag_focused_window) -- One-time tag a window as a game

-- All functions in this file are exported.


local gamemode_binds = {}
local is_active = false
local gamemode_tag = "gamemode"
local games_file = "games.txt"
local enable_notif = true
local notif_time = 2000

local rules = {}

--- Creates a new binding
--- @param keys string
--- @param dsp HL.Dispatcher|function
--- @param opts? HL.BindOptions
--- @return HL.Keybind
local function bind(keys, dsp, opts)
    local gm_bind = hl.bind(keys, dsp, opts)
    table.insert(gamemode_binds, gm_bind)
    return gm_bind
end

--- Sets the state of all gamemode binds to a new value
--- @param value boolean
--- @return nil
local function set_binds_state(value)
    for _, keybind in ipairs(gamemode_binds) do
        keybind:set_enabled(value)
    end
end

--- Enables all gamemode binds
--- @return nil
local function enable()
    if is_active then return end
    is_active = true
    set_binds_state(false)
    if enable_notif then hl.notification.create({ text = "Gamemode ON", time = notif_time, icon = 1 }) end
end

--- Disables all gamemode binds
--- @return nil
local function disable()
    if not is_active then return end
    is_active = false
    set_binds_state(true)
    if enable_notif then hl.notification.create({ text = "Gamemode OFF", time = notif_time, icon = 1 }) end
end

--- Toggles all gamemode binds
--- @return nil
local function toggle()
    if is_active then disable() else enable() end
end

--- Check if gamemode is active
--- @return nil
local function get_is_active()
    return is_active
end

--- Return the tag used by windows marked for automatic gamemode
--- @return string
local function get_tag()
    return gamemode_tag
end

--- Returns the path to the list of games
--- @return string
local function get_game_list_path()
    local config_home = os.getenv("XDG_CONFIG_HOME")
    if not config_home then
        config_home = os.getenv("HOME") .. "/.config"
    end
    return config_home .. "/hypr/" .. games_file
end

--- Returns the list of games
--- @return table
local function get_game_list()
    local game_list_path = get_game_list_path()
    local game_list_file = io.open(game_list_path, "r")
    if not game_list_file then
        game_list_file = io.open(game_list_path, "w")
        if not game_list_file then
            print("Error while trying to access game list file, do you have permission?")
            return {}
        end
        game_list_file:write("")
    end
    local game_list = game_list_file:read("a")
    if not game_list then game_list = "" end
    game_list_file:close()

    local games = {}
    for game in string.gmatch(game_list, "[%g ]+") do
        table.insert(games, game)
    end

    return games
end

--- Returns a table where the keys are the game names and the value is true
--- @return table
local function get_game_list_as_keys()
    local new_list = {}
    for _, game_class in ipairs(get_game_list()) do
        new_list[game_class] = true
    end
    return new_list
end

--- Marks a window as a game
--- @param window HL.Window
--- @return nil
local function tag_window(window)
    if not window then return end
    hl.dispatch(hl.dsp.window.tag({ tag = "+" .. gamemode_tag .. "*", window = window }))
end

--- Unmarks a window as a game
--- @param window HL.Window
--- @return nil
local function untag_window(window)
    if not window then return end
    hl.dispatch(hl.dsp.window.tag({ tag = "-" .. gamemode_tag .. "*", window = window }))
end

--- Marks all windows of a class as a game
--- @param class string
--- @return nil
local function tag_class(class)
    if not class then return end
    for _, window in ipairs(hl.get_windows({ class = class })) do
        tag_window(window)
    end
end

--- Unmarks all windows of a class as a game
--- @param class string
--- @return nil
local function untag_class(class)
    if not class then return end
    for _, window in ipairs(hl.get_windows({ class = class })) do
        untag_window(window)
    end
end

--- Marks the focused window as a game
--- @return nil
local function tag_focused_window()
    local focused = hl.get_active_window()
    if not focused then return end
    tag_window(focused)
end

--- Unmarks the focused window as a game
--- @return nil
local function untag_focused_window()
    local focused = hl.get_active_window()
    if not focused then return end
    untag_window(focused)
end

--- Marks all windows of the focused window class as a game
--- @return nil
local function tag_focused_class()
    local focused = hl.get_active_window()
    if not focused then return end
    tag_class(focused.class)
end

--- Unmarks all windows of the focused window class as a game
--- @return nil
local function untag_focused_class()
    local focused = hl.get_active_window()
    if not focused then return end
    untag_class(focused.class)
end

--- Reloads the games file and updates existing windows
--- @return nil
local function reload_game_list()
    local new_game_list = get_game_list_as_keys()

    for game_class, rule_set in pairs(rules) do
        if not new_game_list[game_class] then
            rule_set:set_enabled(false)
            untag_class(game_class)
        else
            rule_set:set_enabled(true)
            new_game_list[game_class] = nil
        end
    end

    for game_class, _ in pairs(new_game_list) do
        rules[game_class] = hl.window_rule({ name = "gm." .. game_class, match = { class = game_class }, tag = "+" .. gamemode_tag })
    end

    if enable_notif then hl.notification.create({ text = "Reloaded game list", time = notif_time, icon = 5 }) end
end

--- Adds a window class to the permanent list of games and reloads the game list
--- @param id string
--- @return nil
local function add_game(id)
    os.execute("echo \"" .. id .. "\" >> " .. get_game_list_path())
    reload_game_list()
    enable()
    hl.notification.create({ text = "Added " .. id .. " to the game list", time = notif_time, icon = 5 })
end

--- Adds the focused window to the permanent list of games and reloads the game list
local function add_focused_game()
    local focused = hl.get_active_window()
    if not focused then
        hl.notification.create({ text = "No windows focused", time = notif_time, icon = 3 })
    else
        add_game(focused.class)
    end
end

----------------
-- MAIN LOGIC --
----------------

-- Load auto-gamemode list
reload_game_list()

-- Auto-gamemode logic
hl.on("window.active", function (window)
    if window == nil or window.tags == nil then disable() return end
    local found = false

    for _, tag in ipairs(window.tags) do
        if tag == gamemode_tag .. "*" then
            found = true
            break
        end
    end

    if found then
        enable()
    else
        disable()
    end
end)

return {
    get_game_list_path = get_game_list_path,
    get_game_list = get_game_list,
    get_game_list_as_keys = get_game_list_as_keys,
    add_focused_game = add_focused_game,
    add_game = add_game,
    bind = bind,
    disable = disable,
    enable = enable,
    get_tag = get_tag,
    is_active = get_is_active,
    reload = reload_game_list,
    tag_class = tag_class,
    tag_focused_class = tag_focused_class,
    tag_focused_window = tag_focused_window,
    tag_window = tag_window,
    toggle = toggle,
    untag_class = untag_class,
    untag_focused_class = untag_focused_class,
    untag_focused_window = untag_focused_window,
    untag_window = untag_window,
}