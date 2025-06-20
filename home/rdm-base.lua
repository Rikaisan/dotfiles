function RDM_GetFiles()
    local returnedFiles = {
        [".config/bat"] = Directory("config/bat"),
        [".config/neofetch"] = Directory("config/neofetch"),
        [".config/Code"] = Directory("config/Code"),
        [".config/rikai/aliases"] = File("config/rikai/aliases"),
    }

    -- Git
    if not FlagIsSet("ngit") then
        returnedFiles[".config/.gitconfig"] = File(".gitconfig")
    end

    -- Yazi
    if ModuleIsSet("hyprland") then
        returnedFiles[".config/yazi/keymap.toml"] = File("config/yazi/keymap.toml")
    end

    return returnedFiles
end
