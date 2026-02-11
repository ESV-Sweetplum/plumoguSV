function sinusoidalSettingsMenu(settingVars, skipFinalSV)
    local settingsChanged = false
    imgui.Text(("Amplitude:"):obfuscate())
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseCurveSharpness(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 1) or settingsChanged
    settingsChanged = chooseNumPeriods(settingVars) or settingsChanged
    settingsChanged = choosePeriodShift(settingVars) or settingsChanged
    settingsChanged = chooseSVPerQuarterPeriod(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
