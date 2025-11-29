function verticalShiftMenu()
    local menuVars = getMenuVars("verticalShift")

    verticalShiftSettingsMenu(menuVars)
    cache.saveTable("verticalShiftMenu", menuVars)

    simpleActionMenu("Vertically shift SVs between selected notes", 2, verticalShiftSVs, menuVars)
end

function verticalShiftSettingsMenu(menuVars)
    chooseConstantShift(menuVars, 0)
end
