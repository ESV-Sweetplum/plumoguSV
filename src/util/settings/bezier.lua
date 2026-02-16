function bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce, optionalLabel)
    local settingsChanged = false

    settingsChanged = chooseInteractiveBezier(settingVars, optionalLabel or '') or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
