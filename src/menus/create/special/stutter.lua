function stutterMenu(settingVars)
    local settingsChanged = #settingVars.svMultipliers == 0
    settingsChanged = stutterSettingsMenu(settingVars) or settingsChanged
    if settingsChanged then updateStutterMenuSVs(settingVars) end
    displayStutterSVWindows(settingVars)

    AddSeparator()
    simpleActionMenu("Place SVs between selected notes", 2, placeStutterSVs, settingVars)
    simpleActionMenu("Place SSFs between selected notes", 2, placeStutterSSFs, settingVars, true)
end

function stutterSettingsMenu(settingVars)
    local settingsChanged = false
    settingsChanged = chooseControlSecondSV(settingVars) or settingsChanged
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseStutterDuration(settingVars) or settingsChanged
    settingsChanged = BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time") or settingsChanged
    AddSeparator()
    settingsChanged = BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 }) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged

    return settingsChanged
end
