function RDM_AddModules()
    local extraModules = { "fonts", "term", "waybar", "wofi" }
    if IsSet("assets") then
        table.insert(extraModules, "wallpapers")
    end
    return IsSet("extras") and extraModules or {}
end

function RDM_GetFiles()
    local returnedFiles = {
        [""] = Directory("common"):exec("+(*.sh|chwp)") -- Since keys are relative to home, an empty string as the key means the root of the user home.
    }

    if IsSet("assets") then
        returnedFiles[".local/share/icons"] = File("assets/tela-icons.tar.gz")
    end

    return returnedFiles
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("setup-wm.sh")
    end
end
