local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".-#~end%-" .. tag .. "", "")
end

function RDM_AddModules()
    local extraModules = { "wm-common" }
    return IsSet("extras") and extraModules or {}
end

function RDM_GetFiles()
    local returnedFiles = {
        [".config"] = Directory("hyprland/static"):exec("*.sh")
    }

    if IsSet("assets") then
        returnedFiles[".config/hypr"] = Directory("hyprland/assets")
    end

    local function addCustomHyprConfig(path)
        local cfg = Read("hyprland/custom/" .. path)
        cfg = removeSection(cfg, FlagIsSet("laptop") and "desktop" or "laptop")
        cfg = removeSection(cfg, FlagIsSet("es") and "en" or "es")
        returnedFiles[".config/hypr/" .. path] = cfg
    end

    addCustomHyprConfig("globals.lua")

    return returnedFiles
end

