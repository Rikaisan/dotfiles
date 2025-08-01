local categories = {
-- { name, default }
   { "base",        true },
   { "dev",         true },
   { "extra",       true },
   { "gaming",      false },
}
if IsSet("nvidia") then
    table.insert(categories, { "nvidia", true })
end
if IsSet("hyprland") then
    table.insert(categories, { "hyprland", true })
end

function InstallPackages(distro, packageTypes)
    for _, category in ipairs(categories) do
        if not FlagIsSet("auto") then
            io.write("[" .. category[1] .. "]:\n")
            for _, packageType in ipairs(packageTypes) do
                local list = Read(distro .. "/" .. packageType[1] .. "/" .. category[1])
                if list ~= nil then
                    io.write("+--- " .. packageType[1] .. " ---+\n")
                    io.write(list)
                    io.write("\n")
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
        { "flatpak", "flatpak install flathub" }
    }
    if not FlagIsSet("noaur") and not FlagIsSet("naur") then
        table.insert(packageTypes, { "aur",     (IsSet("paru") and "paru" or "yay") .. " -S --needed" })
    end

    if not IsPreview() then
        if IsSet("paru") then
            ForceSpawn("install-paru.sh")
        else
            ForceSpawn("install-yay.sh")
        end
    end

    if not FlagIsSet("noupdate") and not FlagIsSet("noup") then
        os.execute("yay -Syu")
    end

    InstallPackages("arch", packageTypes)
end

function RDM_Init()
    if FlagIsSet("arch") and not IsPreview() then
        InstallForArch()
    end
end
