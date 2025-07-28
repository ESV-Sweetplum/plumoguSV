function showCustomThemeSettings()
    local settingsChanged = false
    imgui.SeparatorText("Custom Theme Actions")
    if (imgui.Button("Reset")) then
        globalVars.customStyle = table.duplicate(DEFAULT_STYLE)
        write()
    end
    KeepSameLine()
    if (imgui.Button("Import")) then
        state.SetValue("importingCustomTheme", true)
    end
    KeepSameLine()
    if (imgui.Button("Export")) then
        local str = stringifyCustomStyle(globalVars.customStyle)
        imgui.SetClipboardText(str)
        print("i!", "Exported custom theme to your clipboard.")
    end
    if (state.GetValue("importingCustomTheme")) then
        local input = state.GetValue("importingCustomThemeInput", "")
        _, input = imgui.InputText("##customThemeStr", input, 69420)
        state.SetValue("importingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            setCustomStyleString(input)
            state.SetValue("importingCustomTheme", false)
        end
        KeepSameLine()
        if (imgui.Button("X")) then
            state.SetValue("importingCustomTheme", false)
        end
    end
    imgui.SeparatorText("Search")
    local searchText = state.GetValue("customTheme_searchText", "")
    _, searchText = imgui.InputText("##CustomThemeSearch", searchText, 100)
    state.SetValue("customTheme_searchText", searchText)
    settingsChanged = ColorInput(globalVars.customStyle, "windowBg", "Window BG") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "popupBg", "Popup BG") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "border", "Border") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "frameBg", "Frame BG") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "frameBgHovered", "Frame BG\n(Hovered)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "frameBgActive", "Frame BG\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "titleBg", "Title BG") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "titleBgActive", "Title BG\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "titleBgCollapsed", "Title BG\n(Collapsed)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "checkMark", "Checkmark") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "sliderGrab", "Slider Grab") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "sliderGrabActive", "Slider Grab\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "button", "Button") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "buttonHovered", "Button\n(Hovered)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "buttonActive", "Button\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "tab", "Tab") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "tabHovered", "Tab\n(Hovered)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "tabActive", "Tab\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "header", "Header") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "headerHovered", "Header\n(Hovered)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "headerActive", "Header\n(Active)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "separator", "Separator") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "text", "Text") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "textSelectedBg", "Text Selected\n(BG)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "scrollbarGrab", "Scrollbar Grab") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "scrollbarGrabHovered", "Scrollbar Grab\n(Hovered)") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "scrollbarGrabActive", "Scrollbar Grab\n(Active)") or
        settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "plotLines", "Plot Lines") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "plotLinesHovered", "Plot Lines\n(Hovered)") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "plotHistogram", "Plot Histogram") or settingsChanged
    settingsChanged = ColorInput(globalVars.customStyle, "plotHistogramHovered", "Plot Histogram\n(Hovered)") or
        settingsChanged
    if (settingsChanged) then
        write(globalVars)
    end
end

function convertStrToShort(str)
    if (str:lower() == str) then
        return str:charAt(1) .. str:sub(-1)
    else
        local newStr = str:charAt(1)
        for char in str:gmatch("%u") do
            newStr = newStr .. char
        end
        return newStr
    end
end

function stringifyCustomStyle(customStyle)
    local keys = table.keys(customStyle)
    local resultStr = ""

    for _, key in ipairs(keys) do
        local value = customStyle[key]
        keyId = convertStrToShort(key)
        local r = math.floor(value.x * 255)
        local g = math.floor(value.y * 255)
        local b = math.floor(value.z * 255)
        local a = math.floor(value.w * 255)
        resultStr = resultStr .. keyId .. ":" .. rgbaToHexa(r, g, b, a) .. ","
    end

    return resultStr:sub(1, -2)
end

function setCustomStyleString(str)
    local keyIdDict = {}

    for _, key in ipairs(table.keys(DEFAULT_STYLE)) do
        keyIdDict[key] = convertStrToShort(key)
    end

    local customStyle = {}

    for kvPair in str:gmatch("[0-9#:a-zA-Z]+") do -- Equivalent to validate, no need to change
        local keyId = kvPair:match("[a-zA-Z]+:"):sub(1, -2)
        local hexa = kvPair:match(":[a-f0-9]+"):sub(2)
        local key = table.indexOf(keyIdDict, keyId)
        if (key ~= -1) then customStyle[key] = hexaToRgba(hexa) / 255 end
    end

    globalVars.customStyle = table.duplicate(customStyle)
end
