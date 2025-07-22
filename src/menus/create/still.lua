function placeStillSVMenu()
    presetButton()
    local menuVars = getMenuVars("placeStill")
    local needSVUpdate = #menuVars.svMultipliers == 0
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate

    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Still")
    if globalVars.showPresetMenu then
        renderPresetMenu("Still", menuVars, settingVars)
        return
    end
    imgui.Text("Still Settings:")
    menuVars.noteSpacing = ComputableInputFloat("Note Spacing", menuVars.noteSpacing, 2, "x")
    menuVars.stillBehavior = Combo("Still Behavior", STILL_BEHAVIOR_TYPES, menuVars.stillBehavior)
    chooseStillType(menuVars)

    AddSeparator()
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil) or needSVUpdate

    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end

    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)

    AddSeparator()
    menuVars.settingVars = settingVars
    simpleActionMenu("Place SVs between selected notes", 2, placeStillSVsParent, menuVars)

    saveVariables(currentSVType .. "StillSettings", settingVars)
    saveVariables("placeStillMenu", menuVars)
end
