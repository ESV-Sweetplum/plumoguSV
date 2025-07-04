function awake()
    local tempGlobalVars = read()
    if (not tempGlobalVars) then tempGlobalVars = table.construct() end

    syncGlobalVarsState(tempGlobalVars)

    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]
end

function syncGlobalVarsState(tempGlobalVars)
    state.SetValue("global_useCustomPulseColor", truthy(tempGlobalVars.useCustomPulseColor))
    state.SetValue("global_pulseColor", table.vectorize4(tempGlobalVars.pulseColor))
    state.SetValue("global_pulseCoefficient", tonumber(tempGlobalVars.pulseCoefficient))
    state.SetValue("global_stepSize", tonumber(tempGlobalVars.stepSize))
    state.SetValue("global_dontReplaceSV", truthy(tempGlobalVars.dontReplaceSV))
    state.SetValue("global_upscroll", truthy(tempGlobalVars.upscroll))
    state.SetValue("global_colorThemeIndex", tonumber(tempGlobalVars.colorThemeIndex))
    state.SetValue("global_styleThemeIndex", tonumber(tempGlobalVars.styleThemeIndex))
    state.SetValue("global_rgbPeriod", tonumber(tempGlobalVars.rgbPeriod))
    state.SetValue("global_cursorTrailIndex", tonumber(tempGlobalVars.cursorTrailIndex))
    state.SetValue("global_cursorTrailShapeIndex", tonumber(tempGlobalVars.cursorTrailShapeIndex))
    state.SetValue("global_effectFPS", tonumber(tempGlobalVars.effectFPS))
    state.SetValue("global_cursorTrailPoints", tonumber(tempGlobalVars.cursorTrailPoints))
    state.SetValue("global_cursorTrailSize", tonumber(tempGlobalVars.cursorTrailSize))
    state.SetValue("global_snakeSpringConstant", tonumber(tempGlobalVars.snakeSpringConstant))
    state.SetValue("global_cursorTrailGhost", truthy(tempGlobalVars.cursorTrailGhost))
    state.SetValue("global_drawCapybara", truthy(tempGlobalVars.drawCapybara))
    state.SetValue("global_drawCapybara2", truthy(tempGlobalVars.drawCapybara2))
    state.SetValue("global_drawCapybara312", truthy(tempGlobalVars.drawCapybara312))
    state.SetValue("global_ignoreNotes", truthy(tempGlobalVars.ignoreNotesOutsideTg))
    state.SetValue("global_hideSVInfo", truthy(tempGlobalVars.hideSVInfo))
    state.SetValue("global_showVibratoWidget", truthy(tempGlobalVars.showVibratoWidget))
    state.SetValue("global_showNoteDataWidget", truthy(tempGlobalVars.showNoteDataWidget))
    state.SetValue("global_showMeasureDataWidget", truthy(tempGlobalVars.showMeasureDataWidget))
    state.SetValue("global_advancedMode", truthy(tempGlobalVars.advancedMode))
    state.SetValue("global_hideAutomatic", truthy(tempGlobalVars.hideAutomatic))
    state.SetValue("global_dontPrintCreation", truthy(tempGlobalVars.dontPrintCreation))
    state.SetValue("global_hotkeyList", tempGlobalVars.hotkeyList)
    GLOBAL_HOTKEY_LIST = tempGlobalVars.hotkeyList
    state.SetValue("global_customStyle", tempGlobalVars.customStyle or table.construct())
    state.SetValue("global_equalizeLinear", truthy(tempGlobalVars.equalizeLinear))
end
