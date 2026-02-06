customStyleIds = {
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
    "loadupOpeningTextColor",
    "loadupPulseTextColorLeft",
    "loadupPulseTextColorRight",
    "loadupBgTl",
    "loadupBgTr",
    "loadupBgBl",
    "loadupBgBr",
}

local customStyleNames = {
    "Window BG",
    "Popup BG",
    "Border",
    "Frame BG",
    "Frame BG\n(Hovered)",
    "Frame BG\n(Active)",
    "Title BG",
    "Title BG\n(Active)",
    "Title BG\n(Collapsed)",
    "Checkmark",
    "Slider Grab",
    "Slider Grab\n(Active)",
    "Button",
    "Button\n(Hovered)",
    "Button\n(Active)",
    "Tab",
    "Tab\n(Hovered)",
    "Tab\n(Active)",
    "Header",
    "Header\n(Hovered)",
    "Header\n(Active)",
    "Separator",
    "Text",
    "Text Selected\n(BG)",
    "Scrollbar Grab",
    "Scrollbar Grab\n(Hovered)",
    "Scrollbar Grab\n(Active)",
    "Plot Lines",
    "Plot Lines\n(Hovered)",
    "Plot Histogram",
    "Plot Histogram\n(Hovered)",
    "Loadup\nOpening Text",
    "Loadup Pulse\nText (Left)",
    "Loadup Pulse\nText (Right)",
    "Loadup BG\n(Top Left)",
    "Loadup BG\n(Top Right)",
    "Loadup BG\n(Bottom Left)",
    "Loadup BG\n(Bottom Right)",
}

function showCustomThemeSettings()
    local settingsChanged = false
    imgui.SeparatorText("Custom Theme Actions")

    if (imgui.Button("Reset")) then
        customStyle = table.duplicate(DEFAULT_STYLE)
        write()
    end
    KeepSameLine()

    if (imgui.Button("Import")) then
        cache.boolean.importingCustomTheme = true
    end
    KeepSameLine()

    if (imgui.Button("Export")) then
        local str = stringifyCustomStyle(customStyle)
        imgui.SetClipboardText(str)
        print("i!", "Exported custom theme to your clipboard.")
    end

    if (cache.boolean.importingCustomTheme) then
        local input = state.GetValue("importingCustomThemeInput", "")
        _, input = imgui.InputText("##customThemeStr", input, 69420)
        state.SetValue("importingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            setCustomStyleString(input)
            settingsChanged = true
            cache.boolean.importingCustomTheme = false
            state.SetValue("importingCustomThemeInput", "")
        end
        KeepSameLine()
        if (imgui.Button("X")) then
            cache.boolean.importingCustomTheme = false
            state.SetValue("importingCustomThemeInput", "")
        end
    end

    imgui.SeparatorText("Search")
    imgui.PushItemWidth(imgui.GetWindowWidth() - 25)
    local searchText = state.GetValue("customTheme_searchText", "")
    _, searchText = imgui.InputText("##CustomThemeSearch", searchText, 100)
    state.SetValue("customTheme_searchText", searchText)
    imgui.PopItemWidth()

    for idx, id in ipairs(customStyleIds) do
        local name = customStyleNames[idx]
        if (not name:lower():find(searchText:lower())) then goto nextId end
        settingsChanged = ColorInput(customStyle, id, name) or settingsChanged
        ::nextId::
    end
    if settingsChanged then
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
    local resultStr = "v2 "

    for _, key in ipairs(keys) do
        local value = customStyle[key]
        keyId = convertStrToShort(key)
        if (key:sub(1, 6) == "loadup") then keyId = keyId .. key:sub(-1):upper() end
        local r = math.round(value.x * 255)
        local g = math.round(value.y * 255)
        local b = math.round(value.z * 255)
        local a = math.round(value.w * 255)
        resultStr = resultStr .. keyId .. "" .. color.rgbaToNdua(r, g, b, a) .. " "
    end

    return resultStr:sub(1, -2)
end

function setCustomStyleString(str, exportInstead)
    local keyIdDict = {}
    for _, key in ipairs(table.keys(DEFAULT_STYLE)) do
        keyIdDict[key] = convertStrToShort(key)
        if (key:sub(1, 6) == "loadup") then keyIdDict[key] = keyIdDict[key] .. key:sub(-1):upper() end
    end

    if (str:sub(1, 3) == "v2 ") then
        parseCustomStyleV2(str:sub(4), keyIdDict, exportInstead)
    else
        parseCustomStyleV1(str, keyIdDict)
    end
end

function parseCustomStyleV2(str, keyIdDict, exportInstead)
    local customStyle = {}

    for kvPair in str:gmatch("[^ ]+") do
        local keyId = kvPair:sub(1, kvPair:len() - 5)
        local keyValue = kvPair:sub(-5)
        local key = table.indexOf(keyIdDict, keyId)
        if (not keyId or key == -1) then goto nextPair end
        customStyle[key] = color.nduaToRgba(keyValue)
        ::nextPair::
    end

    if (not exportInstead) then
        customStyle = table.duplicate(customStyle)
        return
    end

    local outStr = ""

    for k, v in pairs(customStyle) do
        if (k:find("loadup")) then
            outStr = outStr ..
                "loadup." ..
                k:gsub("loadup", "") ..
                " = vector.New(" ..
                math.round(v.x, 2) ..
                ", " .. math.round(v.y, 2) .. ", " .. math.round(v.z, 2) .. ", " .. math.round(v.w, 2) .. ")\n"
        else
            outStr = outStr .. "imgui.PushStyleColor(imgui_col." ..
                k:capitalize() ..
                ", vector.New(" ..
                math.round(v.x, 2) ..
                ", " .. math.round(v.y, 2) .. ", " .. math.round(v.z, 2) .. ", " .. math.round(v.w, 2) .. "))\n"
        end
    end

    imgui.SetClipboardText(outStr)
end

function parseCustomStyleV1(str, keyIdDict)
    local customStyle = {}

    for kvPair in str:gmatch("[0-9#:a-zA-Z]+") do -- Equivalent to validate, no need to change
        local keyId = kvPair:match("[a-zA-Z]+:"):sub(1, -2)
        local hexa = kvPair:match(":[a-f0-9]+"):sub(2)
        local key = table.indexOf(keyIdDict, keyId)
        if (key ~= -1) then customStyle[key] = color.hexaToRgba(hexa) end
    end

    customStyle = table.duplicate(customStyle)
end
