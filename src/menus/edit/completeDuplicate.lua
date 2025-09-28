function completeDuplicateMenu()
    local menuVars = getMenuVars("completeDuplicate")

    local copiedItemCount = #menuVars.objects

    if (copiedItemCount == 0) then
        simpleActionMenu("Copy items between selected notes", 2, storeDuplicateItems, menuVars)
        cache.saveTable("completeDuplicateMenu", menuVars)
        return
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearDuplicateItems, menuVars)
    end

    simpleActionMenu("Paste items at selected notes", 1, placeDuplicateItems, menuVars)
    cache.saveTable("completeDuplicateMenu", menuVars)
end
