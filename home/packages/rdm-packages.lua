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

function InstallPackages(distro, packageTypes)
    for _, category in ipairs(categories) do
        if not FlagIsSet("auto") then
            io.write("[" .. category[1] .. "]:")
            for _, packageType in ipairs(packageTypes) do
                local list = Read(distro .. "/" .. packageType[1] .. "/" .. category[1])
                if list ~= nil then
                    io.write(packageType[1] .. ":")
                    io.write(list)
                end
            end
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
        else
            if not category[2] then
                goto continue
            end
        end

        for _, packageType in ipairs(packageTypes) do
            local list = Read(distro .. "/" .. packageType[1] .. "/" .. category[1])
            if list ~= nil then
                list = list:gsub("\n", " ")
                os.execute(packageType[2] .. " " .. list)
            end
        end

        ::continue::
    end
end

function InstallForArch()
    local packageTypes = {
     -- { name, command }
        { "native",  "sudo pacman -S --needed" },
        { "aur",     "yay -S --needed" },
        { "flatpak", "flatpak install flathub" }
    }

    if not FlagIsSet("preview") then
        ForceSpawn("install-yay.sh")
    end

    if not FlagIsSet("noupdate") then
        os.execute("yay -Syu")
    end

    InstallPackages("arch", packageTypes)
end

function RDM_Init()
    if FlagIsSet("arch") and not FlagIsSet("preview") then
        InstallForArch()
    end
end
