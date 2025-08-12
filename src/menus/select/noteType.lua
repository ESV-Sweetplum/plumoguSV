function selectNoteTypeMenu()
    local menuVars = getMenuVars("selectNoteType")

    _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
    KeepSameLine()
    _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)

    simpleActionMenu("Select notes within region", 2, selectByNoteType, menuVars)

    cache.saveTable("selectNoteTypeMenu", menuVars)
end
