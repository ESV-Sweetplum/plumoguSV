-- Returns generated sv multipliers [Table]
-- Parameters
--    svType              : type of SV to generate [String]
--    settingVars         : list of variables used for the current menu [Table]
--    interlaceMultiplier : interlace multiplier [Int/Float]
function generateSVMultipliers(svType, settingVars, interlaceMultiplier)
    local multipliers = { 727, 69 } ---@type number[]
    if svType == "Linear" then
        multipliers = generateLinearSet(settingVars.startSV, settingVars.endSV,
            settingVars.svPoints + 1, true)
    elseif svType == "Exponential" then
        local behavior = SV_BEHAVIORS[settingVars.behaviorIndex]
        if (settingVars.distanceMode == 3) then
            multipliers = generateExponentialSet2(behavior, settingVars.svPoints + 1, settingVars.startSV,
                settingVars.endSV,
                settingVars.intensity)
        else
            multipliers = generateExponentialSet(behavior, settingVars.svPoints + 1, settingVars.avgSV,
                settingVars.intensity, settingVars.verticalShift)
        end
    elseif svType == "Bezier" then
        multipliers = generateBezierSet(settingVars.p1, settingVars.p2, settingVars.avgSV,
            settingVars.svPoints + 1, settingVars.verticalShift)
    elseif svType == "Hermite" then
        multipliers = generateHermiteSet(settingVars.startSV, settingVars.endSV,
            settingVars.verticalShift, settingVars.avgSV,
            settingVars.svPoints + 1)
    elseif svType == "Sinusoidal" then
        multipliers = generateSinusoidalSet(settingVars.startSV, settingVars.endSV,
            settingVars.periods, settingVars.periodsShift,
            settingVars.svsPerQuarterPeriod,
            settingVars.verticalShift, settingVars.curveSharpness)
    elseif svType == "Circular" then
        local behavior = SV_BEHAVIORS[settingVars.behaviorIndex]
        multipliers = generateCircularSet(behavior, settingVars.arcPercent, settingVars.avgSV,
            settingVars.verticalShift, settingVars.svPoints + 1,
            settingVars.dontNormalize)
    elseif svType == "Random" then
        if not truthy(settingVars.svMultipliers) then
            generateRandomSetMenuSVs(settingVars)
        end
        multipliers = getRandomSet(settingVars.svMultipliers, settingVars.avgSV,
            settingVars.verticalShift, settingVars.dontNormalize)
    elseif svType == "Custom" then
        multipliers = generateCustomSet(settingVars.svMultipliers)
    elseif svType == "Chinchilla" then
        multipliers = generateChinchillaSet(settingVars)
    elseif svType == "Combo" then
        local svType1 = STANDARD_SVS[settingVars.svType1Index]
        local settingVars1 = getSettingVars(svType1, "Combo1")
        local multipliers1 = generateSVMultipliers(svType1, settingVars1, nil)
        local labelText1 = svType1 .. "Combo1"
        cache.saveTable(labelText1 .. "Settings", settingVars1)
        local svType2 = STANDARD_SVS[settingVars.svType2Index]
        local settingVars2 = getSettingVars(svType2, "Combo2")
        local multipliers2 = generateSVMultipliers(svType2, settingVars2, nil)
        local labelText2 = svType2 .. "Combo2"
        cache.saveTable(labelText2 .. "Settings", settingVars2)
        local comboType = COMBO_SV_TYPE[settingVars.comboTypeIndex]
        multipliers = generateComboSet(multipliers1, multipliers2, settingVars.comboPhase,
            comboType, settingVars.comboMultiplier1,
            settingVars.comboMultiplier2, settingVars.dontNormalize,
            settingVars.avgSV, settingVars.verticalShift)
    elseif svType == "Code" then
        multipliers = {}
        local fn = eval(settingVars.code) ---@type fun(t: number): number
        for i = 0, settingVars.svPoints do
            table.insert(multipliers, fn(i / settingVars.svPoints))
        end
    elseif svType == "Stutter1" then
        multipliers = generateStutterSet(settingVars.startSV, settingVars.stutterDuration,
            settingVars.avgSV, settingVars.controlLastSV)
    elseif svType == "Stutter2" then
        multipliers = generateStutterSet(settingVars.endSV, settingVars.stutterDuration,
            settingVars.avgSV, settingVars.controlLastSV)
    end
    if interlaceMultiplier then
        local newMultipliers = {}
        for i = 1, #multipliers do
            table.insert(newMultipliers, multipliers[i])
            table.insert(newMultipliers, multipliers[i] * interlaceMultiplier)
        end
        if settingVars.avgSV and not settingVars.dontNormalize then
            newMultipliers = table.normalize(newMultipliers, settingVars.avgSV, false)
        end
        multipliers = newMultipliers
    end
    return multipliers
end
