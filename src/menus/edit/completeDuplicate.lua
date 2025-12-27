function completeDuplicateMenu()
    local menuVars = getMenuVars("completeDuplicate")
    completeDuplicateSettingsMenu(menuVars)

    local copiedItemCount = #menuVars.objects

    if copiedItemCount == 0 then
        simpleActionMenu("Copy items between selected notes", 2, storeDuplicateItems, menuVars)
        cache.saveTable("completeDuplicateMenu", menuVars)
        return
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearDuplicateItems, menuVars)
    end

    simpleActionMenu("Paste items at selected notes", 1, placeDuplicateItems, menuVars)
    cache.saveTable("completeDuplicateMenu", menuVars)
end

function completeDuplicateSettingsMenu(menuVars)
    BasicCheckbox(menuVars, "dontCloneHos", "Don't Clone Notes",
        "If true, will not copy notes during the complete duplicate process.")
end
