function linearVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Start/End##Vibrato', ' msx', 0, 0.875)
        local func = function(t)
            return settingVars.endMsx * t + settingVars.startMsx * (1 - t)
        end

        simpleActionMenu('Vibrate', 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, 'lowerStart', 'lowerEnd', 'Lower S/E SSFs##Vibrato', 'x')
        SwappableNegatableInputFloat2(settingVars, 'higherStart', 'higherEnd', 'Higher S/E SSFs##Vibrato', 'x')

        local func1 = |t| settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        local func2 = |t| settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)

        simpleActionMenu('Vibrate', 2, |v| ssfVibrato(v, func1, func2), menuVars, false, false,
            separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
