function showKeybindSettings()
    local awaitingIndex = state.GetValue('hotkey_awaitingIndex', 0)
    local keybindHashmap = state.GetValue('hotkey_keybindHashmap', nil)
    if (not keybindHashmap) then keybindHashmap = reconstructKeybindHashmap() end
    for trueIdx, hotkeySettingNumber in pairs(HOTKEY_SETTING_ORDER) do
        local hotkeyIndex = hotkeySettingNumber
        local hotkeyCombo = globalVars.hotkeyList[hotkeyIndex or trueIdx]
        local separator = HOTKEY_SEPARATORS[hotkeyIndex]
        if (separator) then imgui.SeparatorText(separator) end
        local keyOccurrences = keybindHashmap.counts[hotkeyCombo]
        if (keyOccurrences > 1) then
            imgui.PushStyleColor(imgui_col.Text,
                color.int.oRedMask * 200 + color.int.oWhiteMask * 55)
        end
        if imgui.Button(awaitingIndex == hotkeyIndex and 'Listening...##keybind' or hotkeyCombo:fixToSize(70) .. '##' .. hotkeyIndex) then
            if awaitingIndex == hotkeyIndex then
                awaitingIndex = 0
            else
                awaitingIndex = hotkeyIndex
            end
        end
        if (keyOccurrences > 1) then
            HoverToolTip('This key is used in multiple keybind options:\n\n- ' ..
                table.concat(keybindHashmap.names[hotkeyCombo], '\n- ') ..
                '\n\nPlease change a keybind to avoid collisions.')
            imgui.PopStyleColor()
        end
        KeepSameLine()
        imgui.SetCursorPosX(90)
        imgui.Text(HOTKEY_LABELS[hotkeyIndex])
    end
    imgui.SetCursorPos(imgui.GetCursorPos() + vctr2(5))
    simpleActionMenu('Reset Hotkey Settings', 0, function()
        globalVars.hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST)
        write(globalVars)
        reconstructKeybindHashmap()
        awaitingIndex = 0
    end, nil, true, true)
    state.SetValue('hotkey_awaitingIndex', awaitingIndex)
    if awaitingIndex == 0 then return end
    local prefixes, key = kbm.listenForAnyKeyPressed()
    if (key == -1) then return end
    globalVars.hotkeyList[awaitingIndex] = table.concat(prefixes, '+') ..
        (truthy(prefixes) and '+' or '') .. kbm.numToKey(key)
    awaitingIndex = 0
    write(globalVars)
    reconstructKeybindHashmap()
    state.SetValue('hotkey_awaitingIndex', awaitingIndex)
end

function reconstructKeybindHashmap()
    local keybindHashmap = {
        counts = {},
        names = {},
    }
    for hotkeyIndex, hotkeyCombo in pairs(globalVars.hotkeyList) do
        local existingHotkeyComboValue = keybindHashmap.counts[hotkeyCombo]
        if (existingHotkeyComboValue) then
            keybindHashmap.counts[hotkeyCombo] = existingHotkeyComboValue + 1
            table.insert(keybindHashmap.names[hotkeyCombo], HOTKEY_LABELS[hotkeyIndex])
        else
            keybindHashmap.counts[hotkeyCombo] = 1
            keybindHashmap.names[hotkeyCombo] = { HOTKEY_LABELS[hotkeyIndex] }
        end
    end

    state.SetValue('hotkey_keybindHashmap', keybindHashmap)
    return keybindHashmap
end
