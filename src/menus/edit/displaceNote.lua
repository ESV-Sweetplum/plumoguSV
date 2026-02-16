function displaceNoteMenu()
    local menuVars = getMenuVars('displaceNote')
    displaceNoteSettingsMenu(menuVars)
    cache.saveTable('displaceNoteMenu', menuVars)

    simpleActionMenu('Displace selected notes', 1, displaceNoteSVsParent, menuVars)
end

function displaceNoteSettingsMenu(menuVars)
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, 'linearlyChange', 'Change distance over time')
end
