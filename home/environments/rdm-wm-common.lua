function RDM_AddModules()
    local requestedModules = {}

    if IsSet("assets") then
        table.insert(requestedModules, "wallpapers")
    end

    if IsSet("extras") then
        local extraModules = { "fonts", "term", "waybar", "wofi" }
        for _,item in ipairs(extraModules) do
            table.insert(requestedModules, item)
        end
    end

    return requestedModules
end

function RDM_GetFiles()
    local returnedFiles = {
        [""] = Directory("common"):exec("+(*.sh|chwp)") -- Since keys are relative to home, an empty string as the key means the root of the user home.
    }

    if IsSet("assets") then
        returnedFiles[".local/share/icons/tela-icons.tar.gz"] = File("assets/tela-icons.tar.gz")
    end

    return returnedFiles
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("setup-wm.sh")
    end
end
