local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

function RDM_GetFiles()
    local returnedFiles = {
        [""] = Directory("static"),
    }

    if not FlagIsSet("nassets") then
        returnedFiles[".local/share/icons"] = Directory("custom/local/share/icons")
    end

    local function addCustomHyprConfig(path)
        local cfg = Read("custom/config/hypr/" .. path)
        cfg = removeSection(cfg, FlagIsSet("laptop") and "desktop" or "laptop")
        cfg = removeSection(cfg, FlagIsSet("es") and "en" or "es")
        returnedFiles[".config/hypr/" .. path] = cfg
    end

    addCustomHyprConfig("scripts/reload_wallpapers.sh")
    addCustomHyprConfig("modules/monitors.conf")
    addCustomHyprConfig("modules/input.conf")
    addCustomHyprConfig("hyprpaper.conf")

    return returnedFiles
end

function RDM_Delayed()
    if IsSet("setup") and not IsPreview() then
        ForceSpawn("setup-hyprland.sh")
    end

    -- HACK: Hack to add exec perms while RDM doesn't have a way to do it
    if not IsPreview() then
        os.execute("chmod -R +x $HOME/.config/hypr/scripts")
        os.execute("chmod -R +x $HOME/.config/waybar")
        os.execute("chmod +x $HOME/.local/bin/rikai/chwp")
    end
end
