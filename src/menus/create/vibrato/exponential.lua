function exponentialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        swappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.endMsx * t +
                settingVars.startMsx * (1 - t)
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    else
        swappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        swappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]

        local func1 = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and GLOBAL_HOTKEY_LIST[8] or nil)
    end
end
