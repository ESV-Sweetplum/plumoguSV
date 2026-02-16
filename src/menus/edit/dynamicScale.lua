function dynamicScaleMenu()
    local menuVars = getMenuVars('dynamicScale')
    local numNoteTimes = #menuVars.noteTimes
    imgui.Text(#menuVars.noteTimes .. ' note times assigned to scale SVs between')
    addNoteTimesToDynamicScaleButton(menuVars)
    if numNoteTimes == 0 then
        cache.saveTable('dynamicScaleMenu', menuVars)
        return
    else
        clearNoteTimesButton(menuVars)
    end

    AddSeparator()
    if #menuVars.noteTimes < 3 then
        imgui.Text('Not enough note times assigned')
        imgui.Text('Assign 3 or more note times instead')
        cache.saveTable('dynamicScaleMenu', menuVars)
        return
    end
    local numSVPoints = numNoteTimes - 1
    local needSVUpdate = not isTruthy(menuVars.svMultipliers) or (#menuVars.svMultipliers ~= numSVPoints)
    imgui.AlignTextToFramePadding()
    imgui.Text('Shape:')
    KeepSameLine()
    needSVUpdate = chooseStandardSVType(menuVars, true) or needSVUpdate

    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]

    local settingVars = getSettingVars(currentSVType, 'DynamicScale')
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, true, numSVPoints, 'DynamicScale') or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, true) end

    startNextWindowNotCollapsed('SV Info')
    makeSVInfoWindow('SV Info', menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, true)

    local labelText = currentSVType .. 'DynamicScale'
    cache.saveTable(currentSVType .. 'DynamicScaleSettings', settingVars)
    cache.saveTable('dynamicScaleMenu', menuVars)

    simpleActionMenu('Scale spacing between assigned notes', 0, dynamicScaleSVs, menuVars)
end

function clearNoteTimesButton(menuVars)
    if not imgui.Button('Clear all assigned note times', BEEG_BUTTON_SIZE) then return end
    menuVars.noteTimes = {}
end

function addNoteTimesToDynamicScaleButton(menuVars)
    local buttonText = 'Assign selected note times'
    FunctionButton(buttonText, ACTION_BUTTON_SIZE, addSelectedNoteTimesToList, menuVars)
end
