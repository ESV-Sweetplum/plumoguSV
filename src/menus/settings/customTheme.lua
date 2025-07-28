local customStyleIds = {
    "windowBg",
    "popupBg",
    "border",
    "frameBg",
    "frameBgHovered",
    "frameBgActive",
    "titleBg",
    "titleBgActive",
    "titleBgCollapsed",
    "checkMark",
    "sliderGrab",
    "sliderGrabActive",
    "button",
    "buttonHovered",
    "buttonActive",
    "tab",
    "tabHovered",
    "tabActive",
    "header",
    "headerHovered",
    "headerActive",
    "separator",
    "text",
    "textSelectedBg",
    "scrollbarGrab",
    "scrollbarGrabHovered",
    "scrollbarGrabActive",
    "plotLines",
    "plotLinesHovered",
    "plotHistogram",
    "plotHistogramHovered",
}

local customStyleNames = {
    "Window BG",
    "Popup BG",
    "Border",
    "Frame BG",
    "Frame BG (Hovered)",
    "Frame BG (Active)",
    "Title BG",
    "Title BG (Active)",
    "Title BG (Collapsed)",
    "Checkmark",
    "Slider Grab",
    "Slider Grab (Active)",
    "Button",
    "Button (Hovered)",
    "Button (Active)",
    "Tab",
    "Tab (Hovered)",
    "Tab (Active)",
    "Header",
    "Header (Hovered)",
    "Header (Active)",
    "Separator",
    "Text",
    "Text Selected (BG)",
    "Scrollbar Grab",
    "Scrollbar Grab (Hovered)",
    "Scrollbar Grab (Active)",
    "Plot Lines",
    "Plot Lines (Hovered)",
    "Plot Histogram",
    "Plot Histogram (Hovered)"
}

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
    imgui.PushItemWidth(imgui.GetWindowWidth() - 25)
    local oldSearchText = state.GetValue("customTheme_searchText", "")
    _, searchText = imgui.InputText("##CustomThemeSearch", oldSearchText, 100)
    if (searchText ~= oldSearchText) then print("hi") end
    state.SetValue("customTheme_searchText", searchText)
    imgui.PopItemWidth()
    for idx, id in ipairs(customStyleIds) do
        settingsChanged = ColorInput(globalVars.customStyle, id, customStyleNames[idx]) or settingsChanged
    end
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
