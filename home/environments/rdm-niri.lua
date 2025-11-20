function RDM_AddModules()
    local extraModules = { "wm-common" }
    return IsSet("extras") and extraModules or {}
end

function RDM_GetFiles()
    return {
        [".config/niri"] = Directory("niri")
    }
end
