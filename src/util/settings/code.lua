function codeSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    CodeInput(settingVars, "code", "##code",
        "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the scroll velocity multiplier at (100t)% of the way between the first and last selected note times.")
    if (imgui.Button(("Refresh Plot"):obfuscate(), vector.New(ACTION_BUTTON_SIZE.x, 30))) then
        settingsChanged = true
    end
    imgui.Separator()
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged

    return settingsChanged
end
