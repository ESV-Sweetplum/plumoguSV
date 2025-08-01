function sigmoidalVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 7 / 8)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1) * 2
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.startMsx + t * (settingVars.endMsx - settingVars.startMsx)
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]

        local func1 = function(t)
            t = math.clamp(t, 0, 1) * 2
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            t = math.clamp(t, 0, 1) * 2
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[8] or nil)
    end
end
