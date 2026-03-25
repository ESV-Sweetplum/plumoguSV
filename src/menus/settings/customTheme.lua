customStyleIds = {
    'border',
    'button',
    'buttonActive',
    'buttonHovered',
    'checkMark',
    'frameBg',
    'frameBgActive',
    'frameBgHovered',
    'header',
    'headerActive',
    'headerHovered',
    'loadupBgBl',
    'loadupBgBr',
    'loadupBgTl',
    'loadupBgTr',
    'loadupOpeningTextColor',
    'loadupPulseTextColorLeft',
    'loadupPulseTextColorRight',
    'plotHistogram',
    'plotHistogramHovered',
    'plotLines',
    'plotLinesHovered',
    'popupBg',
    'scrollbarGrab',
    'scrollbarGrabActive',
    'scrollbarGrabHovered',
    'separator',
    'sliderGrab',
    'sliderGrabActive',
    'tab',
    'tabActive',
    'tabHovered',
    'tableBorderLight',
    'tableBorderStrong',
    'text',
    'textSelectedBg',
    'titleBg',
    'titleBgActive',
    'titleBgCollapsed',
    'windowBg',
}

local customStyleNames = {
    'Border',
    'Button',
    'Button\n(Active)',
    'Button\n(Hovered)',
    'Checkmark',
    'Frame BG',
    'Frame BG\n(Active)',
    'Frame BG\n(Hovered)',
    'Header',
    'Header\n(Active)',
    'Header\n(Hovered)',
    'Loadup BG\n(Bottom Left)',
    'Loadup BG\n(Bottom Right)',
    'Loadup BG\n(Top Left)',
    'Loadup BG\n(Top Right)',
    'Loadup\nOpening Text',
    'Loadup Pulse\nText (Left)',
    'Loadup Pulse\nText (Right)',
    'Plot Histogram',
    'Plot Histogram\n(Hovered)',
    'Plot Lines',
    'Plot Lines\n(Hovered)',
    'Popup BG',
    'Scrollbar Grab',
    'Scrollbar Grab\n(Active)',
    'Scrollbar Grab\n(Hovered)',
    'Separator',
    'Slider Grab',
    'Slider Grab\n(Active)',
    'Tab',
    'Tab\n(Active)',
    'Tab\n(Hovered)',
    'Table Border\n(Light)',
    'Table Border\n(Strong)',
    'Text',
    'Text Selected\n(BG)',
    'Title BG',
    'Title BG\n(Active)',
    'Title BG\n(Collapsed)',
    'Window BG',
}

function showCustomThemeSettings()
    local settingsChanged = false
    imgui.SeparatorText("Editing '" .. globalVars.colorThemeName:gsub('custom_', '') .. "'")

    if (imgui.Button('Reset')) then
        globalCustomStyle = table.duplicate(DEFAULT_STYLE)
        globalVars.colorThemeName = 'Original'
        write(globalVars)
    end
    KeepSameLine()
    if (imgui.Button('Rename')) then
        cache.boolean.renamingCustomTheme = not cache.boolean.renamingCustomTheme
    end
    KeepSameLine()
    if (imgui.Button('Export')) then
        local str = stringifyCustomStyle(globalCustomStyle)
        imgui.SetClipboardText(str)
        print('s!', 'Exported custom theme to your clipboard.')
    end
    KeepSameLine()
    if (imgui.Button('Delete')) then
        print('e!', 'Deleted custom theme.')
        globalVars.customStyles[globalVars.colorThemeName] = nil
        globalVars.colorThemeName = 'Original'
        cache.settingTypeIndex = table.indexOf(SETTING_TYPES, 'Appearance')
        write(globalVars)
    end
    if (cache.boolean.renamingCustomTheme) then
        local input = state.GetValue('renamingCustomThemeInput', '')
        imgui.SetNextItemWidth(130)
        _, input = imgui.InputTextWithHint('##customThemeStr', 'New Custom Theme Name', input, 69420)
        state.SetValue('renamingCustomThemeInput', input)
        KeepSameLine()
        if (imgui.Button('Send')) then
            local newName = 'custom_' .. input
            globalVars.customStyles[newName] = globalCustomStyle
            globalVars.customStyles[globalVars.colorThemeName] = nil
            globalVars.colorThemeName = newName
            settingsChanged = true
            cache.boolean.renamingCustomTheme = false
            state.SetValue('renamingCustomThemeInput', '')
        end
        KeepSameLine()
        if (imgui.Button('X')) then
            cache.boolean.renamingCustomTheme = false
            state.SetValue('renamingCustomThemeInput', '')
        end
    end

    imgui.SeparatorText('Search')

    imgui.PushItemWidth(imgui.GetWindowWidth() - 25)
    local searchText = state.GetValue('customTheme_searchText', '')
    _, searchText = imgui.InputTextWithHint('##CustomThemeSearch', 'Border, Title, Frame BG, etc.', searchText, 100)
    state.SetValue('customTheme_searchText', searchText)
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
        for char in str:gmatch('%u') do
            newStr = newStr .. char
        end
        return newStr
    end
end

function stringifyCustomStyle(customStyle)
    local keys = table.keys(customStyle)
    local resultStr = 'v2 '

    for _, key in ipairs(keys) do
        local value = customStyle[key]
        keyId = convertStrToShort(key)
        if (key:sub(1, 6) == 'loadup') then keyId = keyId .. key:sub(-1):upper() end
        local r = math.round(value.x * 255)
        local g = math.round(value.y * 255)
        local b = math.round(value.z * 255)
        local a = math.round(value.w * 255)
        resultStr = resultStr .. keyId .. '' .. color.rgbaToNdua(r, g, b, a) .. ' '
    end

    return resultStr:sub(1, -2)
end

function setCustomStyleString(str, exportInstead)
    local keyIdDict = {}
    for _, key in ipairs(table.keys(DEFAULT_STYLE)) do
        keyIdDict[key] = convertStrToShort(key)
        if (key:sub(1, 6) == 'loadup') then keyIdDict[key] = keyIdDict[key] .. key:sub(-1):upper() end
    end

    if (str:sub(1, 3) == 'v2 ') then
        parseCustomStyleV2(str:sub(4), keyIdDict, exportInstead)
        return
    end
    print('e!', 'This version of theming is no longer supported. We apologize for any inconvenience.')
end

function parseCustomStyleV2(str, keyIdDict, exportInstead)
    local customStyle = {}

    for kvPair in str:gmatch('[^ ]+') do
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
        local newName = 'custom_Import' .. state.UnixTime
        globalVars.customStyles[newName] = globalCustomStyle
        globalVars.colorThemeName = newName
        print('s!', 'Imported a new theme into your custom theme list.')
        return
    end

    local outStr = ''

    for k, v in pairs(customStyle) do
        if (k:find('loadup')) then
            outStr = outStr ..
                'loadup.' ..
                k:gsub('loadup', '') ..
                ' = vector.New(' ..
                math.round(v.x, 2) ..
                ', ' .. math.round(v.y, 2) .. ', ' .. math.round(v.z, 2) .. ', ' .. math.round(v.w, 2) .. ')\n'
        else
            outStr = outStr .. 'imgui.PushStyleColor(imgui_col.' ..
                k:capitalize() ..
                ', vector.New(' ..
                math.round(v.x, 2) ..
                ', ' .. math.round(v.y, 2) .. ', ' .. math.round(v.z, 2) .. ', ' .. math.round(v.w, 2) .. '))\n'
        end
    end

    imgui.SetClipboardText(outStr)
end
