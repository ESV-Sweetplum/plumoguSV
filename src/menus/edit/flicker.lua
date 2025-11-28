function flickerMenu()
    local menuVars = getMenuVars("flicker")

    flickerSettingsMenu(menuVars)

    cache.saveTable("flickerMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Add flicker SVs between selected notes", 2, flickerSVs, menuVars)
end

function flickerSettingsMenu(menuVars)
    menuVars.flickerTypeIndex = Combo("Flicker Type", FLICKER_TYPES, menuVars.flickerTypeIndex)
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
    BasicInputInt(menuVars, "numFlickers", "Flickers", { 1, 9999 })
    if (globalVars.advancedMode) then chooseFlickerPosition(menuVars) end
end
