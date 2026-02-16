globalVars = {
    advancedMode = false,
    colorThemeName = "Original",
    comboizeSelect = false,
    cursorTrailGhost = false,
    cursorTrailIndex = 1,
    cursorTrailPoints = 10,
    cursorTrailShapeIndex = 1,
    cursorTrailSize = 5,
    customStyles = {},
    defaultProperties = { settings = {}, menu = {} },
    disableKofiMessage = false,
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
    useMinDisplacementMultiplier = true,
}

DEFAULT_GLOBAL_VARS = table.duplicate(globalVars)

function setGlobalVars(tempGlobalVars)
    globalVars.advancedMode = isTruthy(tempGlobalVars.advancedMode)
    globalVars.colorThemeName = tempGlobalVars.colorThemeName or "Original"
    globalVars.comboizeSelect = isTruthy(tempGlobalVars.comboizeSelect)
    globalVars.cursorTrailGhost = isTruthy(tempGlobalVars.cursorTrailGhost)
    globalVars.cursorTrailIndex = tn(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailPoints = math.clamp(tn(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailShapeIndex = tn(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.cursorTrailSize = tn(tempGlobalVars.cursorTrailSize)
    -- `table.duplicate` must be used to prevent YAML issues; more specifically, when setting a table's value to nil (which should erase the key) and writing, the YAML file contains the key with a null parameter. To fix this, we iterate over the table and reconstruct it from scratch (which is what `table.duplicate` does).
    globalVars.customStyles = table.duplicate(tempGlobalVars.customStyles)
    globalVars.disableKofiMessage = isTruthy(tempGlobalVars.disableKofiMessage)
    globalVars.disableLoadup = isTruthy(tempGlobalVars.disableLoadup)
    globalVars.dontPrintCreation = isTruthy(tempGlobalVars.dontPrintCreation)
    globalVars.dontReplaceSV = isTruthy(tempGlobalVars.dontReplaceSV)
    globalVars.drawCapybara = isTruthy(tempGlobalVars.drawCapybara)
    globalVars.drawCapybara2 = isTruthy(tempGlobalVars.drawCapybara2)
    globalVars.drawCapybara312 = isTruthy(tempGlobalVars.drawCapybara312)
    globalVars.dynamicBackgroundIndex = tn(tempGlobalVars.dynamicBackgroundIndex)
    globalVars.effectFPS = tn(tempGlobalVars.effectFPS)
    globalVars.equalizeLinear = isTruthy(tempGlobalVars.equalizeLinear, true)
    globalVars.hideAutomatic = isTruthy(tempGlobalVars.hideAutomatic)
    globalVars.hideSVInfo = isTruthy(tempGlobalVars.hideSVInfo)
    globalVars.hotkeyList = table.validate(DEFAULT_HOTKEY_LIST, table.duplicate(tempGlobalVars.hotkeyList), true)
    globalVars.ignoreNotes = isTruthy(tempGlobalVars.ignoreNotesOutsideTg)
    globalVars.maxDisplacementMultiplierExponent = tn(tempGlobalVars.maxDisplacementMultiplierExponent)
    globalVars.performanceMode = isTruthy(tempGlobalVars.performanceMode)
    globalVars.printLegacyLNMessage = isTruthy(tempGlobalVars.printLegacyLNMessage, true)
    globalVars.pulseCoefficient = tn(tempGlobalVars.pulseCoefficient)
    globalVars.pulseColor = table.vectorize4(tempGlobalVars.pulseColor)
    globalVars.restrictSinusoidalPeriod = isTruthy(tempGlobalVars.restrictSinusoidalPeriod, true)
    globalVars.rgbPeriod = tn(tempGlobalVars.rgbPeriod)
    globalVars.showMeasureDataWidget = isTruthy(tempGlobalVars.showMeasureDataWidget)
    globalVars.showNoteDataWidget = isTruthy(tempGlobalVars.showNoteDataWidget)
    globalVars.showSVInfoVisualizer = isTruthy(tempGlobalVars.showSVInfoVisualizer, true)
    globalVars.showVibratoWidget = isTruthy(tempGlobalVars.showVibratoWidget)
    globalVars.snakeSpringConstant = tn(tempGlobalVars.snakeSpringConstant)
    globalVars.stepSize = tn(tempGlobalVars.stepSize)
    globalVars.styleThemeIndex = tn(tempGlobalVars.styleThemeIndex)
    globalVars.upscroll = isTruthy(tempGlobalVars.upscroll)
    globalVars.useCustomPulseColor = isTruthy(tempGlobalVars.useCustomPulseColor)
    globalVars.useEndTimeOffsets = isTruthy(tempGlobalVars.useEndTimeOffsets)
    globalVars.useMinDisplacementMultiplier = isTruthy(tempGlobalVars.useMinDisplacementMultiplier, true)

    -- All fields below are colors that must be vectorized to properly perform color arithmetic.
    local forceVectorizeList = { "border", "loadupOpeningTextColor", "loadupPulseTextColorLeft",
        "loadupPulseTextColorRight", "loadupBgTl", "loadupBgTr", "loadupBgBl", "loadupBgBr" }

    if (tempGlobalVars.customStyles) then
        for themeName, themeData in pairs(globalVars.customStyles) do
            for _, key in ipairs(forceVectorizeList) do
                if (themeData[key]) then
                    globalVars.customStyles[themeName][key] = table.vectorize4(themeData[key])
                end
            end
        end
        globalCustomStyle = tempGlobalVars.customStyles[globalVars.colorThemeName] or {}
    else
        globalCustomStyle = {}
    end

    -- All fields below are not settings, but menu operators that need to be kept on hot-reload.
    globalVars.placeTypeIndex = state.GetValue("global.placeTypeIndex", globalVars.placeTypeIndex)
    globalVars.editToolIndex = state.GetValue("global.editToolIndex", globalVars.editToolIndex)
    globalVars.selectTypeIndex = state.GetValue("global.selectTypeIndex", globalVars.selectTypeIndex)
end
