function RDM_GetFiles()
    return {
        [".local/share/fonts"] = Directory("fonts"),
        [".config/fontconfig"] = Directory("config/fontconfig"),
    }
end