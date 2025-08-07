function RDM_GetFiles()
    return {
        [".config/waybar"] = Directory("waybar"):exec("+(*.py|*.sh)")
    }
end
