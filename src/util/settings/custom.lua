function customSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = importCustomSVs(settingVars) or settingsChanged
    settingsChanged = chooseCustomMultipliers(settingVars) or settingsChanged
    if not (svPointsForce and skipFinalSV) then AddSeparator() end
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    adjustNumberOfMultipliers(settingVars)
    return settingsChanged
end

function importCustomSVs(settingVars)
    local svsParsed = false
    local customSVText = state.GetValue("import_customText") or "Import SV values here"
    local imguiFlag = imgui_input_text_flags.AutoSelectAll
    _, customSVText = imgui.InputText("##customSVs", customSVText, 99999, imguiFlag)
    KeepSameLine()
    if imgui.Button(("Parse##customSVs"):obfuscate(), SECONDARY_BUTTON_SIZE) then
        local regex = "(-?%d*%.?%d+)"
        local values = {}
        for value, _ in string.gmatch(customSVText, regex) do
            table.insert(values, tn(value))
        end
        if #values >= 1 then
            settingVars.svMultipliers = values
            settingVars.selectedMultiplierIndex = 1
            settingVars.svPoints = #values
            svsParsed = true
        end
        customSVText = "Import SV values here"
    end
    state.SetValue("import_customText", customSVText)
    HelpMarker("Paste custom SV values in the box then hit the parse button (ex. 2 -1 2 -1)")
    return svsParsed
end

function adjustNumberOfMultipliers(settingVars)
    if settingVars.svPoints > #settingVars.svMultipliers then
        local difference = settingVars.svPoints - #settingVars.svMultipliers
        for _ = 1, difference do
            table.insert(settingVars.svMultipliers, 1)
        end
    end
    if settingVars.svPoints >= #settingVars.svMultipliers then return end

    if settingVars.selectedMultiplierIndex > settingVars.svPoints then
        settingVars.selectedMultiplierIndex = settingVars.svPoints
    end
    local difference = #settingVars.svMultipliers - settingVars.svPoints
    for _ = 1, difference do
        table.remove(settingVars.svMultipliers)
    end
end
