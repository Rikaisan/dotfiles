function RDM_GetFiles()
    return {
        [".config/bat"] = Directory("bat")
    }
end

function RDM_Delayed()
    if IsSet("setup") then
        os.execute("bat cache --build")
    end
end