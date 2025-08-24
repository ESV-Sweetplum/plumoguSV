function duplicateHolisticMenu()
    local menuVars = getMenuVars("duplicateHolistic")

    local copiedItemCount = #menuVars.HOs + #menuVars.TLs + #menuVars.BMs + #menuVars.SVs + #menuVars.SSFs

    if (copiedItemCount == 0) then
        simpleActionMenu("Copy items between selected notes", 2, instanceItems, menuVars)
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearInstance, menuVars)
    end

    if copiedItemCount == 0 then
        cache.saveTable("duplicateHolisticMenu", menuVars)
        return
    end
    cache.saveTable("duplicateHolisticMenu", menuVars)
    AddSeparator()
    simpleActionMenu("Paste items at current time", 0, pasteInstance, menuVars)
end
