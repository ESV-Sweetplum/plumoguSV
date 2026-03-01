function linearSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    if (globalVars.advancedMode) then
        settingsChanged = chooseLinearDistanceMode(settingVars) or settingsChanged
    end
    if (settingVars.distanceMode == 1) then
        settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    end
    if (settingVars.distanceMode == 2) then
        local startChanged = false
        settingVars.startSV, startChanged = NegatableComputableInputFloat('Start SV', settingVars.startSV, 2, 'x')
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged or startChanged
    end
    if (settingVars.distanceMode == 3) then
        local endChanged = false
        settingVars.endSV, endChanged = NegatableComputableInputFloat('End SV', settingVars.endSV, 2, 'x')
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged or endChanged
    end
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
