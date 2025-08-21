function RDM_AddModules()
    local extraModules = { "fonts", "term", "vscode", "aliases" }
    if not FlagIsSet("ngit") then
        table.insert(extraModules, "git")
    end
    return extraModules
end
