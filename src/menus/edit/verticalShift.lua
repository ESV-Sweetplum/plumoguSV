function verticalShiftMenu()
    local menuVars = getMenuVars("verticalShift")
    chooseConstantShift(menuVars, 0)
    saveVariables("verticalShiftMenu", menuVars)

    AddSeparator()
    local buttonText = "Vertically shift SVs between selected notes"
    simpleActionMenu(buttonText, 2, verticalShiftSVs, menuVars)
end
