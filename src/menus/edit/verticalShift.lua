function verticalShiftMenu()
    local menuVars = getMenuVars("verticalShift")

    verticalShiftSettingsMenu(menuVars)
    cache.saveTable("verticalShiftMenu", menuVars)

    AddSeparator()
    local buttonText = "Vertically shift SVs between selected notes"
    simpleActionMenu(buttonText, 2, verticalShiftSVs, menuVars)
end

function verticalShiftSettingsMenu(menuVars)
    chooseConstantShift(menuVars, 0)
end
