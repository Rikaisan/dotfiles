function RDM_GetFiles()
    local returnedFiles = {
        [".config/bat"] = Directory("config/bat"),
        [".config/Code"] = Directory("config/Code"),
        [".config/fontconfig"] = Directory("config/fontconfig"),
        [".config/neofetch"] = Directory("config/neofetch"),
        [".config/rikai/aliases"] = File("config/rikai/aliases"),
    }

    -- Git
    if not FlagIsSet("ngit") then
        returnedFiles[".config/.gitconfig"] = File(".gitconfig")
    end

    -- Yazi
    if IsSet("hyprland") then
        returnedFiles[".config/yazi/keymap.toml"] = File("config/yazi/keymap.toml")
    end

    return returnedFiles
end
