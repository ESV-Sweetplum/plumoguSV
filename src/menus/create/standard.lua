STANDARD_SVS = {
    "Linear",
    "Exponential",
    "Bezier",
    "Hermite",
    "Sinusoidal",
    "Circular",
    "Random",
    "Custom",
    "Chinchilla",
    "Combo",
    "Code"
}

function placeStandardSVMenu()
    PresetButton()
    local menuVars = getMenuVars("placeStandard")
    local needSVUpdate = #menuVars.svMultipliers == 0
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate

    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Standard")
    if globalVars.showPresetMenu then
        renderPresetMenu("Standard", menuVars, settingVars)
        return
    end

    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil) or needSVUpdate
    AddSeparator()

    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end

    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)

    menuVars.settingVars = settingVars
    AddSeparator()
    if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and settingVars.distanceMode == 2) then
        simpleActionMenu("Place SVs between selected notes##Exponential", 2, placeExponentialSpecialSVs, menuVars)
    else
        simpleActionMenu("Place SVs between selected notes", 2, placeSVs, menuVars)
    end
    simpleActionMenu("Place SSFs between selected notes", 2, placeSSFs, menuVars, true)

    cache.saveTable(currentSVType .. "StandardSettings", settingVars)
    cache.saveTable("placeStandardMenu", menuVars)
end
