function exponentialSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseSVBehavior(settingVars) or settingsChanged

    settingsChanged = chooseIntensity(settingVars) or settingsChanged
    if (globalVars.advancedMode) then
        settingsChanged = chooseExponentialDistanceMode(settingVars) or settingsChanged
    end
    if (settingVars.distanceMode ~= 3) then
        settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    end
    if (settingVars.distanceMode == 1) then
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    elseif (settingVars.distanceMode == 2) then
        settingsChanged = chooseDistance(settingVars) or settingsChanged
    else
        settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    end
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
