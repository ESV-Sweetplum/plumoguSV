function checkForGlobalHotkeys()
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_note_tg])) then jumpToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_note_lock])) then changeNoteLockMode() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_end_offset])) then toggleUseEndOffsets() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.move_selection_to_tg])) then moveSelectionToTg() end
end
