globalVars = {
    stepSize = 5,
    dontReplaceSV = false,
    upscroll = false,
    colorThemeIndex = 1,
    styleThemeIndex = 1,
    effectFPS = 90,
    cursorTrailIndex = 1,
    cursorTrailShapeIndex = 1,
    cursorTrailPoints = 10,
    cursorTrailSize = 5,
    snakeSpringConstant = 1,
    cursorTrailGhost = false,
    rgbPeriod = 2,
    drawCapybara = false,
    drawCapybara2 = false,
    drawCapybara312 = false,
    selectTypeIndex = 1,
    placeTypeIndex = 1,
    editToolIndex = 1,
    showPresetMenu = false,
    scrollGroupIndex = 1,
    hideSVInfo = false,
    showSVInfoVisualizer = true,
    showVibratoWidget = false,
    showNoteDataWidget = false,
    showMeasureDataWidget = false,
    ignoreNotesOutsideTg = false,
    advancedMode = false,
    performanceMode = false,
    hideAutomatic = false,
    pulseCoefficient = 0,
    pulseColor = vector.New(0, 0, 0, 0),
    useCustomPulseColor = false,
    hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST),
    customStyle = {},
    dontPrintCreation = false,
    equalizeLinear = true,
    comboizeSelect = false,
    defaultProperties = { settings = {}, menu = {} },
    presets = {},
    dynamicBackgroundIndex = 1,
    disableLoadup = false,
    useEndTimeOffsets = false
}

DEFAULT_GLOBAL_VARS = table.duplicate(globalVars)

function setGlobalVars(tempGlobalVars)
    globalVars.useCustomPulseColor = truthy(tempGlobalVars.useCustomPulseColor)
    globalVars.pulseColor = table.vectorize4(tempGlobalVars.pulseColor)
    globalVars.pulseCoefficient = tn(tempGlobalVars.pulseCoefficient)
    globalVars.stepSize = tn(tempGlobalVars.stepSize)
    globalVars.dontReplaceSV = truthy(tempGlobalVars.dontReplaceSV)
    globalVars.upscroll = truthy(tempGlobalVars.upscroll)
    globalVars.colorThemeIndex = tn(tempGlobalVars.colorThemeIndex)
    globalVars.styleThemeIndex = tn(tempGlobalVars.styleThemeIndex)
    globalVars.rgbPeriod = tn(tempGlobalVars.rgbPeriod)
    globalVars.cursorTrailIndex = tn(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailShapeIndex = tn(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.effectFPS = tn(tempGlobalVars.effectFPS)
    globalVars.cursorTrailPoints = math.clamp(tn(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailSize = tn(tempGlobalVars.cursorTrailSize)
    globalVars.snakeSpringConstant = tn(tempGlobalVars.snakeSpringConstant)
    globalVars.cursorTrailGhost = truthy(tempGlobalVars.cursorTrailGhost)
    globalVars.drawCapybara = truthy(tempGlobalVars.drawCapybara)
    globalVars.drawCapybara2 = truthy(tempGlobalVars.drawCapybara2)
    globalVars.drawCapybara312 = truthy(tempGlobalVars.drawCapybara312)
    globalVars.ignoreNotes = truthy(tempGlobalVars.ignoreNotesOutsideTg)
    globalVars.hideSVInfo = truthy(tempGlobalVars.hideSVInfo)
    globalVars.showSVInfoVisualizer = truthy(tempGlobalVars.showSVInfoVisualizer, true)
    globalVars.showVibratoWidget = truthy(tempGlobalVars.showVibratoWidget)
    globalVars.showNoteDataWidget = truthy(tempGlobalVars.showNoteDataWidget)
    globalVars.showMeasureDataWidget = truthy(tempGlobalVars.showMeasureDataWidget)
    globalVars.advancedMode = truthy(tempGlobalVars.advancedMode)
    globalVars.performanceMode = truthy(tempGlobalVars.performanceMode)
    globalVars.hideAutomatic = truthy(tempGlobalVars.hideAutomatic)
    globalVars.dontPrintCreation = truthy(tempGlobalVars.dontPrintCreation)
    globalVars.hotkeyList = table.validate(DEFAULT_HOTKEY_LIST, table.duplicate(tempGlobalVars.hotkeyList), true)
    globalVars.customStyle = tempGlobalVars.customStyle or {}

    local forceVectorizeList = { "border", "loadupOpeningTextColor", "loadupPulseTextColorLeft",
        "loadupPulseTextColorRight", "loadupBgTl", "loadupBgTr", "loadupBgBl", "loadupBgBr" }
    for _, key in ipairs(forceVectorizeList) do
        if (globalVars.customStyle[key]) then
            globalVars.customStyle[key] = table.vectorize4(globalVars.customStyle[key])
        end
    end

    globalVars.equalizeLinear = truthy(tempGlobalVars.equalizeLinear, true)
    globalVars.comboizeSelect = truthy(tempGlobalVars.comboizeSelect)
    globalVars.disableLoadup = truthy(tempGlobalVars.disableLoadup)
    globalVars.dynamicBackgroundIndex = tn(tempGlobalVars.dynamicBackgroundIndex)
    globalVars.useEndTimeOffsets = truthy(tempGlobalVars.useEndTimeOffsets)
end
