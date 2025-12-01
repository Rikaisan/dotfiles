function RDM_GetFiles()
    return {
        [".config/rikai/aliases"] = File("config/rikai/aliases"),
        [".local/bin/rikai"] = Directory("bin")
    }
end
