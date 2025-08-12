local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

function RDM_GetFiles()
    local zshenv = Read("zsh/.zshenv")
    if not FlagIsSet("vivaldi") then
        zshenv = removeSection(zshenv, "vivaldi")
    end

    local zshrc = Read("zsh/.zshrc")
    if not IsSet("hyprland") or not IsSet("setup") or IsSet("laptop") then
        zshrc = removeSection(zshrc, "hypr")
    end

    return {
        [".zshrc"] = zshrc,
        [".zshenv"] = zshenv,
    }
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("zsh/install-ohmyzsh.sh")
    end
end