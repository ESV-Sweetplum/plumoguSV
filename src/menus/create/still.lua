function placeStillSVMenu()
    PresetButton()
    local menuVars = getMenuVars('placeStill')
    local needSVUpdate = not isTruthy(menuVars.svMultipliers)
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate

    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, 'Still')
    if globalVars.showPresetMenu then
        local presetSelected = renderPresetMenu('Still', menuVars, settingVars)
        if (not presetSelected) then
            cache.saveTable(currentSVType .. 'StillSettings', settingVars)
            cache.saveTable('placeStillMenu', menuVars)
        end
        return
    end
    imgui.Text('Still Settings:')
    menuVars.noteSpacing = ComputableInputFloat('Note Spacing', menuVars.noteSpacing, 2, 'x')
    menuVars.stillBehavior = Combo('Still Behavior', STILL_BEHAVIOR_TYPES, menuVars.stillBehavior, nil, nil,
        { 'Apply the Still across the entire selected region.', 'Apply the Stills across the selected note groups.' })
    chooseStillType(menuVars)

    AddSeparator()
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil, 'Still') or needSVUpdate

    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end

    startNextWindowNotCollapsed('SV Info')
    makeSVInfoWindow('SV Info', menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)

    menuVars.settingVars = settingVars
    simpleActionMenu('Place SVs between selected notes', 2, placeStillSVsParent, menuVars)

    cache.saveTable(currentSVType .. 'StillSettings', settingVars)
    cache.saveTable('placeStillMenu', menuVars)
end
