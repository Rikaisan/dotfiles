function RDM_AddModules()
    local extraModules = { "fonts", "term", "waybar", "wofi" }
    if IsSet("assets") then
        table.insert(extraModules, "wallpapers")
    end
    return extraModules
end

function RDM_GetFiles()
    local returnedFiles = {
        [""] = Directory("common"):exec("chwp") -- Since keys are relative to home, an empty string as the key means the root of the user home.
    }

    if IsSet("assets") then
        returnedFiles[""] = Directory("assets")
    end

    return returnedFiles
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("setup-wm.sh")
    end
end
