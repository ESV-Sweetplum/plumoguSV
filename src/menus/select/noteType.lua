function selectNoteTypeMenu()
    local menuVars = getMenuVars("selectNoteType")

    _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
    KeepSameLine()
    _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)
    ---@diagnostic disable-next-line: undefined-global
    if hitobject_type then
        _, menuVars.normal = imgui.Checkbox("Select Normals", menuVars.normal)
        KeepSameLine()
        _, menuVars.mine = imgui.Checkbox("Select Mines", menuVars.mine)
    end

    simpleActionMenu("Select notes within region", 2, selectByNoteType, menuVars)
    cache.saveTable("selectNoteTypeMenu", menuVars)
end
