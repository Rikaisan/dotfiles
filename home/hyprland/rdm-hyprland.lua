local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

function RDM_AddModules()
    local extraModules = { "fonts", "term", "waybar", "wofi" }
    if IsSet("assets") then
        table.insert(extraModules, "wallpapers")
    end
    return extraModules
end

function RDM_GetFiles()
    local returnedFiles = {
        [""] = Directory("static"):exec("+(*.sh|chwp)") -- Since keys are relative to home, an empty string as the key means the root of the user home.
    }

    if IsSet("assets") then
        returnedFiles[".local/share/icons"] = Directory("custom/local/share/icons")
    end

    local function addCustomHyprConfig(path, executable)
        local cfg = Read("custom/config/hypr/" .. path)
        cfg = removeSection(cfg, FlagIsSet("laptop") and "desktop" or "laptop")
        cfg = removeSection(cfg, FlagIsSet("es") and "en" or "es")
        if executable then
            cfg = cfg:exec()
        end
        returnedFiles[".config/hypr/" .. path] = cfg
    end

    addCustomHyprConfig("scripts/reload_wallpapers.sh", true)
    addCustomHyprConfig("modules/workspaces.conf")
    addCustomHyprConfig("modules/autostart.conf")
    addCustomHyprConfig("modules/monitors.conf")
    addCustomHyprConfig("modules/input.conf")
    addCustomHyprConfig("hyprpaper.conf")

    return returnedFiles
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("setup-hyprland.sh")
    end
end
