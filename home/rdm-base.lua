function RDM_AddModules()
    local extraModules = { "fonts", "term", "vscode" }
    if not FlagIsSet("ngit") then
        table.insert(extraModules, "git")
    end
    return extraModules
end
