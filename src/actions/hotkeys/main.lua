function checkForGlobalHotkeys()
    if (isTruthy(state.GetValue('hotkey_awaitingIndex', 0))) then return end -- Disable hotkeys when editing keybinds

    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_note_tg])) then jumpToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_note_lock])) then changeNoteLockMode() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_end_offset])) then toggleUseEndOffsets() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.move_selection_to_tg])) then moveSelectionToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_prev_tg])) then goToPrevTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_next_tg])) then goToNextTg() end

    for _, preset in pairs(globalVars.presets) do
        if (not preset.flags.enabled) then goto nextPreset end
        if (kbm.pressedKeyCombo(preset.flags.combo)) then
            print('i!', 'Activated hotkey for preset "' .. preset.name .. '".')
            local data = table.parse(preset.data)
            globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.type)
            cache.saveTable(preset.menu .. preset.type .. 'Settings', data.settingVars)
            cache.saveTable('place' .. preset.type .. 'Menu', data.menuVars)
            globalVars.showPresetMenu = false
        end
        ::nextPreset::
    end
end
