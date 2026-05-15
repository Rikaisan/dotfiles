function RDM_GetFiles()
    return {
        [".local/bin/rikai"] = Directory("bin"):exec()
    }
end
