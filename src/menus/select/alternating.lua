function selectAlternatingMenu()
    local menuVars = getMenuVars("selectAlternating")
    BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
    BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })
    cache.saveTable("selectAlternatingMenu", menuVars)

    AddSeparator()
    simpleActionMenu(
        "Select a note every " ..
        menuVars.every .. pluralize(" note, from note #", menuVars.every, 5) .. menuVars.offset,
        2,
        selectAlternating, menuVars)
end
