function RDM_GetFiles()
    local files = {
        [".config/fontconfig"] = Directory("config/fontconfig")
    }

    if IsSet("assets") then
        files[".local/share/fonts"] = Directory("fonts")
    end

    return files
end