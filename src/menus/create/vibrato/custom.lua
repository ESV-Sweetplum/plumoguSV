function customVibratoMenu(menuVars, settingVars, separateWindow)
    local typingCode = false
    if (menuVars.vibratoMode == 1) then
        CodeInput(settingVars, "code", "##code",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        if imgui.IsItemActive() then
            typingCode = true
        else
            typingCode = false
        end
        local func = eval(settingVars.code)
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, typingCode, separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    else
        CodeInput(settingVars, "code1", "##code1",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        if imgui.IsItemActive() then
            typingCode = true
        else
            typingCode = false
        end
        CodeInput(settingVars, "code2", "##code2",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        if imgui.IsItemActive() then
            typingCode = true
        else
            typingCode = typingCode or false
        end
        local func1 = eval(settingVars.code1)
        local func2 = eval(settingVars.code2)
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            ssfVibrato(v, func1, func2)
        end, menuVars, false, typingCode, separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    end
end
