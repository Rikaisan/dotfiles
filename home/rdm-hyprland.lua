local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

local returnedFiles = {
    [".config"] = Directory("hypr_configs"),
    [".local/bin/rikai/chwp"] = File("local/bin/rikai/chwp"),
    [".gtkrc-2.0"] = File(".gtkrc-2.0"),
}

local function addCustomHyprConfig(path)
    local cfg = Read("config/hypr/" .. path)
    cfg = removeSection(cfg, FlagIsSet("laptop") and "desktop" or "laptop")
    cfg = removeSection(cfg, FlagIsSet("es") and "en" or "es")
    returnedFiles[".config/hypr/" .. path] = cfg
end

addCustomHyprConfig("scripts/reload_wallpapers.sh")
addCustomHyprConfig("modules/monitors.conf")
addCustomHyprConfig("modules/input.conf")
addCustomHyprConfig("hyprpaper.conf")

if ModuleIsSet("setup") and not OptionIsSet("preview") then
    ForceSpawn("setup-hyprland.sh")
end

return returnedFiles