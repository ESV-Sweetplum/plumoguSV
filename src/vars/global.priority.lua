globalVars = {
    advancedMode = false,
    colorThemeIndex = 1,
    comboizeSelect = false,
    cursorTrailGhost = false,
    cursorTrailIndex = 1,
    cursorTrailPoints = 10,
    cursorTrailShapeIndex = 1,
    cursorTrailSize = 5,
    customStyle = {},
    defaultProperties = { settings = {}, menu = {} },
    disableLoadup = false,
    dontPrintCreation = false,
    dontReplaceSV = false,
    drawCapybara = false,
    drawCapybara2 = false,
    drawCapybara312 = false,
    dynamicBackgroundIndex = 1,
    editToolIndex = 1,
    effectFPS = 90,
    equalizeLinear = true,
    hideAutomatic = false,
    hideSVInfo = false,
    hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST),
    ignoreNotesOutsideTg = false,
    maxDisplacementMultiplierExponent = 6,
    performanceMode = false,
    placeTypeIndex = 1,
    presets = {},
    printLegacyLNMessage = true,
    pulseCoefficient = 0,
    pulseColor = vector.New(0, 0, 0, 0),
    restrictSinusoidalPeriod = true,
    rgbPeriod = 3,
    scrollGroupIndex = 1,
    selectTypeIndex = 1,
    showMeasureDataWidget = false,
    showNoteDataWidget = false,
    showPresetMenu = false,
    showSVInfoVisualizer = true,
    showVibratoWidget = false,
    snakeSpringConstant = 1,
    stepSize = 5,
    styleThemeIndex = 1,
    upscroll = false,
    useCustomPulseColor = false,
    useEndTimeOffsets = false,
}

DEFAULT_GLOBAL_VARS = table.duplicate(globalVars)

function setGlobalVars(tempGlobalVars)
    globalVars.advancedMode = truthy(tempGlobalVars.advancedMode)
    globalVars.colorThemeIndex = tn(tempGlobalVars.colorThemeIndex)
    globalVars.comboizeSelect = truthy(tempGlobalVars.comboizeSelect)
    globalVars.cursorTrailGhost = truthy(tempGlobalVars.cursorTrailGhost)
    globalVars.cursorTrailIndex = tn(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailPoints = math.clamp(tn(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailShapeIndex = tn(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.cursorTrailSize = tn(tempGlobalVars.cursorTrailSize)
    globalVars.customStyle = tempGlobalVars.customStyle or {}
    globalVars.disableLoadup = truthy(tempGlobalVars.disableLoadup)
    globalVars.dontPrintCreation = truthy(tempGlobalVars.dontPrintCreation)
    globalVars.dontReplaceSV = truthy(tempGlobalVars.dontReplaceSV)
    globalVars.drawCapybara = truthy(tempGlobalVars.drawCapybara)
    globalVars.drawCapybara2 = truthy(tempGlobalVars.drawCapybara2)
    globalVars.drawCapybara312 = truthy(tempGlobalVars.drawCapybara312)
    globalVars.dynamicBackgroundIndex = tn(tempGlobalVars.dynamicBackgroundIndex)
    globalVars.effectFPS = tn(tempGlobalVars.effectFPS)
    globalVars.equalizeLinear = truthy(tempGlobalVars.equalizeLinear, true)
    globalVars.hideAutomatic = truthy(tempGlobalVars.hideAutomatic)
    globalVars.hideSVInfo = truthy(tempGlobalVars.hideSVInfo)
    globalVars.hotkeyList = table.validate(DEFAULT_HOTKEY_LIST, table.duplicate(tempGlobalVars.hotkeyList), true)
    globalVars.ignoreNotes = truthy(tempGlobalVars.ignoreNotesOutsideTg)
    globalVars.maxDisplacementMultiplierExponent = tn(tempGlobalVars.maxDisplacementMultiplierExponent)
    globalVars.performanceMode = truthy(tempGlobalVars.performanceMode)
    globalVars.printLegacyLNMessage = truthy(tempGlobalVars.printLegacyLNMessage, true)
    globalVars.pulseCoefficient = tn(tempGlobalVars.pulseCoefficient)
    globalVars.pulseColor = table.vectorize4(tempGlobalVars.pulseColor)
    globalVars.restrictSinusoidalPeriod = truthy(tempGlobalVars.restrictSinusoidalPeriod, true)
    globalVars.rgbPeriod = tn(tempGlobalVars.rgbPeriod)
    globalVars.showMeasureDataWidget = truthy(tempGlobalVars.showMeasureDataWidget)
    globalVars.showNoteDataWidget = truthy(tempGlobalVars.showNoteDataWidget)
    globalVars.showSVInfoVisualizer = truthy(tempGlobalVars.showSVInfoVisualizer, true)
    globalVars.showVibratoWidget = truthy(tempGlobalVars.showVibratoWidget)
    globalVars.snakeSpringConstant = tn(tempGlobalVars.snakeSpringConstant)
    globalVars.stepSize = tn(tempGlobalVars.stepSize)
    globalVars.styleThemeIndex = tn(tempGlobalVars.styleThemeIndex)
    globalVars.upscroll = truthy(tempGlobalVars.upscroll)
    globalVars.useCustomPulseColor = truthy(tempGlobalVars.useCustomPulseColor)
    globalVars.useEndTimeOffsets = truthy(tempGlobalVars.useEndTimeOffsets)

    -- All fields below are colors that must be vectorized to properly perform color arithmetic.
    local forceVectorizeList = { "border", "loadupOpeningTextColor", "loadupPulseTextColorLeft",
        "loadupPulseTextColorRight", "loadupBgTl", "loadupBgTr", "loadupBgBl", "loadupBgBr" }
    for _, key in ipairs(forceVectorizeList) do
        if (globalVars.customStyle[key]) then
            globalVars.customStyle[key] = table.vectorize4(globalVars.customStyle[key])
        end
    end

    -- All fields below are not settings, but menu operators that need to be kept on hot-reload.
    globalVars.placeTypeIndex = state.GetValue("global.placeTypeIndex", globalVars.placeTypeIndex)
    globalVars.editToolIndex = state.GetValue("global.editToolIndex", globalVars.editToolIndex)
    globalVars.selectTypeIndex = state.GetValue("global.selectTypeIndex", globalVars.selectTypeIndex)
end
