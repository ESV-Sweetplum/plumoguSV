function bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = provideBezierWebsiteLink(settingVars) or settingsChanged
    settingsChanged = chooseBezierPoints(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end

function provideBezierWebsiteLink(settingVars)
    local coordinateParsed = false
    local bezierText = state.GetValue("bezier_text") or "https://cubic-bezier.com/"
    _, bezierText = imgui.InputText("##bezierWebsite", bezierText, 100, imgui_input_text_flags.AutoSelectAll)
    KeepSameLine()
    if imgui.Button("Parse##bezierValues", SECONDARY_BUTTON_SIZE) then
        local regex = "(-?%d*%.?%d+)"
        local values = {}
        for value, _ in string.gmatch(bezierText, regex) do
            table.insert(values, math.toNumber(value))
        end
        if #values >= 4 then
            settingVars.p1 = vector.New(values[1], values[2])
            settingVars.p2 = vector.New(values[3], values[4])
            coordinateParsed = true
        end
        bezierText = "https://cubic-bezier.com/"
    end
    state.SetValue("bezier_text", bezierText)
    HelpMarker(
        "This site lets you play around with a cubic bezier whose graph represents the motion/path of notes. After finding a good shape for note motion, paste the resulting url into the input box and hit the parse button to import the coordinate values. Alternatively, enter 4 numbers to use as the coordinates using the given inputs.")
    return coordinateParsed
end
