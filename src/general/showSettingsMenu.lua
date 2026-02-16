-- Shows the settings menu for the current SV type
-- Returns whether or not any settings changed [Boolean]
-- Parameters
--    currentSVType : current SV type to choose the settings for [String]
--    settingVars   : list of variables used for the current menu [Table]
--    skipFinalSV   : whether or not to skip choosing the final SV [Boolean]
--    svPointsForce : number of SV points to force [Int or nil]
function showSettingsMenu(currentSVType, settingVars, skipFinalSV, svPointsForce, optionalLabel)
    if currentSVType == 'Linear' then
        return linearSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Exponential' then
        return exponentialSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Bezier' then
        return bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce, optionalLabel)
    elseif currentSVType == 'Hermite' then
        return hermiteSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Sinusoidal' then
        return sinusoidalSettingsMenu(settingVars, skipFinalSV)
    elseif currentSVType == 'Circular' then
        return circularSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Random' then
        return randomSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Custom' then
        return customSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Chinchilla' then
        return chinchillaSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == 'Combo' then
        return comboSettingsMenu(settingVars)
    elseif currentSVType == 'Code' then
        return codeSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    end
end
