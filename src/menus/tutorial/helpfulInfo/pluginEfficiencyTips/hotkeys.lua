function showHotkeyTutorial()
    imgui.SeparatorText("Basic Hotkeys")
    imgui.TextWrapped(
        "The most basic hotkeys are ones that can simply speed up your SV making process; whether that be placing SVs/SSFs or quickly editing settings.")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.exec_primary] .. '" to quickly place SVs.')
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.exec_secondary] .. '" to quickly place SSFs.')
    imgui.BulletText('If you have a vibrato window, press "' ..
        globalVars.hotkeyList[hotkeys_enum.exec_vibrato] .. '" to quickly place vibrato.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.swap_primary] .. '" to quickly swap any swappable parameters.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.negate_primary] .. '" to quickly negatable any negatable parameters.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.reset_secondary] .. '" to quickly reset any resettable parameters.')
    imgui.PopStyleColor()
    imgui.SeparatorText("Advanced Hotkeys")
    imgui.TextWrapped(
        "Typically, these hotkeys are used in combination with advanced mode to efficiently switch between timing groups:")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_prev_tg] .. '" to go to the previous timing group.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_next_tg] .. '" to go to the next timing group.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_note_tg] .. '" to go to the timing group of the selected note.')
    imgui.PopStyleColor()
    imgui.SeparatorText("Lock Mode")
    imgui.TextWrapped(
        'Sometimes, typing letters/numbers on your keyboard will unintentionally interact with the editor in ways you don\'t want. You can remedy this by using the built-in "NOTE LOCK" feature.')
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. '" to change the locking mode.')
    imgui.PopStyleColor()
end
