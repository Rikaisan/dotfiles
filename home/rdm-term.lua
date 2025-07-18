local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

function RDM_GetFiles()
    local zshenv = Read(".zshenv")
    if not FlagIsSet("vivaldi") then
        zshenv = removeSection(zshenv, "vivaldi")
    end

    local zshrc = Read(".zshrc")
    if not ModuleIsSet("hyprland") then
        zshrc = removeSection(zshrc, "hypr")
    end

    return {
        [".config/kitty"] = Directory("config/kitty"),
        [".config/starship.toml"] = File("config/starship.toml"),
        [".zshrc"] = zshrc,
        [".zshenv"] = zshenv,
    }
end

function RDM_Delayed()
    if not FlagIsSet("preview") then
        ForceSpawn("install-ohmyzsh.sh")
    end
end