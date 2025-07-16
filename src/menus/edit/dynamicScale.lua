function dynamicScaleMenu()
    local menuVars = getMenuVars("dynamicScale")
    local numNoteTimes = #menuVars.noteTimes
    imgui.Text(#menuVars.noteTimes .. " note times assigned to scale SVs between")
    addNoteTimesToDynamicScaleButton(menuVars)
    if numNoteTimes == 0 then
        saveVariables("dynamicScaleMenu", menuVars)
        return
    else
        clearNoteTimesButton(menuVars)
    end

    AddSeparator()
    if #menuVars.noteTimes < 3 then
        imgui.Text("Not enough note times assigned")
        imgui.Text("Assign 3 or more note times instead")
        saveVariables("dynamicScaleMenu", menuVars)
        return
    end
    local numSVPoints = numNoteTimes - 1
    local needSVUpdate = #menuVars.svMultipliers == 0 or (#menuVars.svMultipliers ~= numSVPoints)
    imgui.AlignTextToFramePadding()
    imgui.Text("Shape:")
    KeepSameLine()
    needSVUpdate = chooseStandardSVType(menuVars, true) or needSVUpdate

    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    if currentSVType == "Sinusoidal" then
        imgui.Text("Import sinusoidal values using 'Custom' instead")
        saveVariables("dynamicScaleMenu", menuVars)
        return
    end

    local settingVars = getSettingVars(currentSVType, "DynamicScale")
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, true, numSVPoints) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, true) end

    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, true)

    local labelText = currentSVType .. "DynamicScale"
    saveVariables(labelText .. "Settings", settingVars)
    saveVariables("dynamicScaleMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Scale spacing between assigned notes", 0, dynamicScaleSVs, menuVars)
end

function clearNoteTimesButton(menuVars)
    if not imgui.Button("Clear all assigned note times", BEEG_BUTTON_SIZE) then return end
    menuVars.noteTimes = {}
end

function addNoteTimesToDynamicScaleButton(menuVars)
    local buttonText = "Assign selected note times"
    Button(buttonText, ACTION_BUTTON_SIZE, addSelectedNoteTimesToList, menuVars)
end
