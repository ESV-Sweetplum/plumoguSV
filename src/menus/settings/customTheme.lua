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
    imgui.SeparatorText("Editing '" .. globalVars.colorThemeName:gsub("custom_", "") .. "'")

    if (imgui.Button("Reset")) then
        globalCustomStyle = table.duplicate(DEFAULT_STYLE)
        globalVars.colorThemeName = "Original"
        write(globalVars)
    end
    KeepSameLine()
    if (imgui.Button("Rename")) then
        cache.boolean.renamingCustomTheme = not cache.boolean.renamingCustomTheme
    end
    KeepSameLine()
    if (imgui.Button("Export")) then
        local str = stringifyCustomStyle(globalCustomStyle)
        imgui.SetClipboardText(str)
        print("i!", "Exported custom theme to your clipboard.")
    end
    KeepSameLine()
    if (imgui.Button("Delete")) then
        print("e!", "Deleted custom theme.")
        globalVars.customStyles[globalVars.colorThemeName] = nil
        globalVars.colorThemeName = "Original"
        cache.settingTypeIndex = table.indexOf(SETTING_TYPES, "Appearance")
        write(globalVars)
    end
    if (cache.boolean.renamingCustomTheme) then
        local input = state.GetValue("renamingCustomThemeInput", "")
        imgui.SetNextItemWidth(130)
        _, input = imgui.InputText("##customThemeStr", input, 69420)
        state.SetValue("renamingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            local newName = "custom_" .. input
            globalVars.customStyles[newName] = globalCustomStyle
            globalVars.customStyles[globalVars.colorThemeName] = nil
            globalVars.colorThemeName = newName
            settingsChanged = true
            cache.boolean.renamingCustomTheme = false
            state.SetValue("renamingCustomThemeInput", "")
        end
        KeepSameLine()
        if (imgui.Button("X")) then
            cache.boolean.renamingCustomTheme = false
            state.SetValue("renamingCustomThemeInput", "")
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
        settingsChanged = ColorInput(globalCustomStyle, id, name) or settingsChanged
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
        return
    end
    print("e!", "This version of theming is no longer supported. We apologize for any inconvenience.")
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
        globalCustomStyle = table.duplicate(customStyle)
        if (not globalVars.customStyles) then globalVars.customStyles = {} end
        local newName = "custom_Import" .. state.UnixTime
        globalVars.customStyles[newName] = globalCustomStyle
        globalVars.colorThemeName = newName
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
