local function removeSection(text, tag)
    return text:gsub("#~" .. tag ..".*#~end%-" .. tag, "")
end

function RDM_GetFiles()
    local zshenv = Read(".zshenv")
    if not FlagIsSet("vivaldi") then
        zshenv = removeSection(zshenv, "vivaldi")
    end

    local zshrc = Read(".zshrc")
    if not IsSet("hyprland") then
        zshrc = removeSection(zshrc, "hypr")
    end

    return {
        [".zshrc"] = zshrc,
        [".zshenv"] = zshenv,
    }
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        ForceSpawn("install-ohmyzsh.sh")
    end
end