function checkForGlobalHotkeys()
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_note_tg])) then jumpToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_note_lock])) then changeNoteLockMode() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_end_offset])) then toggleUseEndOffsets() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.move_selection_to_tg])) then moveSelectionToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_prev_tg])) then
        print(game.getTimingGroupList())
    end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_next_tg])) then
    end
end
