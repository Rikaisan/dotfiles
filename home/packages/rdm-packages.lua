local categories = {
-- { name, default }
   { "base",        true },
   { "dev",         true },
   { "extra",       true },
   { "gaming",      false },
}
if FlagIsSet("nvidia") then
    table.insert(categories, { "nvidia", false })
end
if ModuleIsSet("hyprland") then
    table.insert(categories, { "hyprland", false })
end

function InstallForArch()
    local packageTypes = {
     -- { name, command }
        { "native",  "sudo pacman -S --needed --noconfirm" },
        { "aur",     "yay -S --needed --noconfirm" },
        { "flatpak", "flatpak install flathub" }
    }

    if not OptionIsSet("preview") then
        ForceSpawn("install-yay.sh")
    end

    if not OptionIsSet("noupdate") then
        os.execute("yay -Syu")
    end

    for _, category in ipairs(categories) do
        io.write("Would you like to install " .. category[1] .. "? [" .. (category[2] and "Y/n" or "y/N") .. "] ")
        local answer = io.read()
        answer = answer:lower()
        answer = answer:gsub("%s", "")
        answer = answer:gsub("%c", "")
        if category[2] then
            if answer:sub(1,1) == "n" then
                goto continue
            end
        else
            if answer:sub(1,1) ~= "y" then
                goto continue
            end
        end

        for _, packageType in ipairs(packageTypes) do
            local list = Read("arch/" .. packageType[1] .. "/" .. category[1])
            if list ~= nil then
                list = list:gsub("\n", " ")
                os.execute(packageType[2] .. " " .. list)
            end
        end

        ::continue::
    end
end

if OptionIsSet("arch") and not OptionIsSet("preview") then
    InstallForArch()
end