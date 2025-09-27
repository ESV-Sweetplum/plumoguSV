function stutterMenu(settingVars)
    local settingsChanged = #settingVars.svMultipliers == 0
    settingsChanged = stutterSettingsMenu(settingVars) or settingsChanged
    if settingsChanged then updateStutterMenuSVs(settingVars) end
    displayStutterSVWindows(settingVars)

    AddSeparator()
    simpleActionMenu("Place SVs between selected notes", 2, placeStutterSVs, settingVars)
end

function stutterSettingsMenu(settingVars)
    local settingsChanged = false
    settingsChanged = chooseControlSecondSV(settingVars) or settingsChanged
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    if (not settingVars.linearlyChange) then
        settingsChanged = chooseStutterDuration(settingVars) or settingsChanged
    else
        settingsChanged = SwappableNegatableInputFloat2(settingVars, "stutterDuration", "stutterDuration2",
            "S/E % Duration",
            "%%", 0)
        settingVars.stutterDuration = math.clamp(settingVars.stutterDuration, 1, 99)
        settingVars.stutterDuration2 = math.clamp(settingVars.stutterDuration2, 1, 99)
    end
    settingsChanged = BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time") or settingsChanged
    AddSeparator()
    settingsChanged = BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 }) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged

    return settingsChanged
end
