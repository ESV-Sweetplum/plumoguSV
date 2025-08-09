function showKeybindSettings()
    local awaitingIndex = state.GetValue("hotkey_awaitingIndex", 0)
    for hotkeyIndex, hotkeyCombo in pairs(globalVars.hotkeyList) do
        if imgui.Button(awaitingIndex == hotkeyIndex and "Listening...##listening" or hotkeyCombo .. "##" .. hotkeyIndex) then
            if (awaitingIndex == hotkeyIndex) then
                awaitingIndex = 0
            else
                awaitingIndex = hotkeyIndex
            end
        end
        KeepSameLine()
        imgui.SetCursorPosX(111)
        imgui.Text("" .. HOTKEY_LABELS[hotkeyIndex])
    end
    AddSeparator()
    simpleActionMenu("Reset Hotkey Settings", 0, function()
        globalVars.hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST)
        -- write(globalVars)
        awaitingIndex = 0
    end, nil, true, true)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
    if (awaitingIndex == 0) then return end
    local prefixes, key = kb.listenForAnyKeyPressed()
    if (key == -1) then return end
    globalVars.hotkeyList[awaitingIndex] = table.concat(prefixes, "+") ..
        (truthy(prefixes) and "+" or "") .. kb.numToKey(key)
    awaitingIndex = 0
    -- write(globalVars)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
end
