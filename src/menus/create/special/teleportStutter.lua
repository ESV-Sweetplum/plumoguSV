function teleportStutterMenu(settingVars)
    teleportStutterSettingsMenu(settingVars)

    AddSeparator()
    simpleActionMenu("Place SVs between selected notes", 2, placeTeleportStutterSVs, settingVars)
    simpleActionMenu("Place SSFs between selected notes", 2, placeTeleportStutterSSFs, settingVars, true)
end

function teleportStutterSettingsMenu(settingVars)
    if settingVars.useDistance then
        chooseDistance(settingVars)
        HelpMarker("Start SV teleport distance")
    else
        chooseStartSVPercent(settingVars)
    end
    chooseMainSV(settingVars)
    BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 })
    chooseAverageSV(settingVars)
    chooseFinalSV(settingVars, false)
    BasicCheckbox(settingVars, "useDistance", "Use distance for start SV")
    BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time")
end
