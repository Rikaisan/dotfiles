local function removeSection(text, tag)
    return text:gsub("//~" .. tag ..".*//~end%-" .. tag, "")
end

function RDM_AddModules()
    local extraModules = { "wm-common" }
    return IsSet("extras") and extraModules or {}
end

function RDM_GetFiles()
    local returnedFiles = {}

    local function addCustomConfig(path, executable)
        local cfg = Read("niri/" .. path)
        cfg = removeSection(cfg, FlagIsSet("laptop") and "desktop" or "laptop")
        cfg = removeSection(cfg, FlagIsSet("es") and "en" or "es")
        if executable then
            cfg = cfg:exec()
        end
        returnedFiles[".config/niri/" .. path] = cfg
    end

    addCustomConfig("config.kdl")

    return returnedFiles
end
