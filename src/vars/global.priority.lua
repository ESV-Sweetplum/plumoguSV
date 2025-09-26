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
    globalVars.pulseCoefficient = math.toNumber(tempGlobalVars.pulseCoefficient)
    globalVars.stepSize = math.toNumber(tempGlobalVars.stepSize)
    globalVars.dontReplaceSV = truthy(tempGlobalVars.dontReplaceSV)
    globalVars.upscroll = truthy(tempGlobalVars.upscroll)
    globalVars.colorThemeIndex = math.toNumber(tempGlobalVars.colorThemeIndex)
    globalVars.styleThemeIndex = math.toNumber(tempGlobalVars.styleThemeIndex)
    globalVars.rgbPeriod = math.toNumber(tempGlobalVars.rgbPeriod)
    globalVars.cursorTrailIndex = math.toNumber(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailShapeIndex = math.toNumber(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.effectFPS = math.toNumber(tempGlobalVars.effectFPS)
    globalVars.cursorTrailPoints = math.clamp(math.toNumber(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailSize = math.toNumber(tempGlobalVars.cursorTrailSize)
    globalVars.snakeSpringConstant = math.toNumber(tempGlobalVars.snakeSpringConstant)
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
    if (globalVars.customStyle.border) then
        globalVars.customStyle.border = table.vectorize4(globalVars.customStyle
            .border)
    end
    globalVars.equalizeLinear = truthy(tempGlobalVars.equalizeLinear, true)
    globalVars.comboizeSelect = truthy(tempGlobalVars.comboizeSelect)
    globalVars.disableLoadup = truthy(tempGlobalVars.disableLoadup)
    globalVars.dynamicBackgroundIndex = math.toNumber(tempGlobalVars.dynamicBackgroundIndex)
    globalVars.useEndTimeOffsets = truthy(tempGlobalVars.useEndTimeOffsets)
end
