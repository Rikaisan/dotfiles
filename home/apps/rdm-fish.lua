function RDM_AddModules()
    return { "starship" }
end

function RDM_GetFiles()
    return {
        [".config/fish"] = Directory("fish"),
    }
end

function RDM_Delayed()
    if not IsPreview() and IsSet("setup") then
        print("Updating user shell...")
        os.execute("chsh -s /usr/bin/fish")
    end
end