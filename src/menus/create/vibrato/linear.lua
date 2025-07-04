function linearVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        customSwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        local func = function(t)
            return settingVars.endMsx * t + settingVars.startMsx * (1 - t)
        end
        addSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, nil, menuVars, false, false, separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    else
        customSwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        customSwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")

        local func1 = function(t)
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        addSeparator()

        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, nil, menuVars, false, false,
            separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    end
end
