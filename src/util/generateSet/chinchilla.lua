function generateChinchillaSet(settingVars)
    if settingVars.svPoints == 1 then return { settingVars.avgSV, settingVars.avgSV } end

    local avgValue = settingVars.avgSV - settingVars.verticalShift
    local chinchillaSet = {}
    local percents = generateLinearSet(0, 1, settingVars.svPoints + 1)
    local newPercents = {}
    for i = 1, #percents do
        local currentPercent = percents[i]
        local newPercent = scalePercent(settingVars, currentPercent) --
        table.insert(newPercents, newPercent)
    end
    local numValues = settingVars.svPoints
    for i = 1, numValues do
        local distance = newPercents[i + 1] - newPercents[i]
        local slope = distance * numValues
        chinchillaSet[i] = slope
    end
    chinchillaSet = table.normalize(chinchillaSet, avgValue, true)
    for i = 1, #chinchillaSet do
        chinchillaSet[i] = chinchillaSet[i] + settingVars.verticalShift
    end
    table.insert(chinchillaSet, settingVars.avgSV)
    return chinchillaSet
end

-- Scales a percent value based on the selected scale type

function scalePercent(settingVars, percent)
    local behaviorType = SV_BEHAVIORS[settingVars.behaviorIndex]
    local slowDownType = behaviorType == "Slow down"
    local workingPercent = percent
    if slowDownType then workingPercent = 1 - percent end
    local newPercent
    local a = settingVars.chinchillaIntensity
    local scaleType = CHINCHILLA_TYPES[settingVars.chinchillaTypeIndex]
    if scaleType == "Exponential" then
        local exponent = a * (workingPercent - 1)
        newPercent = (workingPercent * math.exp(exponent))
    elseif scaleType == "Polynomial" then
        local exponent = a + 1
        newPercent = workingPercent ^ exponent
    elseif scaleType == "Circular" then
        if a == 0 then return percent end

        local b = 1 / (a ^ (a + 1))
        local radicand = (b + 1) ^ 2 + b ^ 2 - (workingPercent + b) ^ 2
        newPercent = b + 1 - math.sqrt(radicand)
    elseif scaleType == "Sine Power" then
        local exponent = math.log(a + 1)
        local base = math.sin(math.pi * (workingPercent - 1) * 0.5) + 1
        newPercent = workingPercent * (base ^ exponent)
    elseif scaleType == "Arc Sine Power" then
        local exponent = math.log(a + 1)
        local base = 2 * math.asin(workingPercent) / math.pi
        newPercent = workingPercent * (base ^ exponent)
    elseif scaleType == "Inverse Power" then
        local denominator = 1 + (workingPercent ^ -a)
        newPercent = 2 * workingPercent / denominator
    elseif "Peter Stock" then
        --[[
        Algorithm based on a modified version of Peter Stock's StackExchange answer.
        Peter Stock (https://math.stackexchange.com/users/1246531/peter-stock)
        SmoothStep: Looking for a continuous family of interpolation functions
        URL (version: 2023-11-04): https://math.stackexchange.com/q/4800509
        --]]
        if a == 0 then return percent end

        local c = a / (1 - a)
        newPercent = (workingPercent ^ 2) * (1 + c) / (workingPercent + c)
    end
    if slowDownType then newPercent = 1 - newPercent end
    return math.clamp(newPercent, 0, 1)
end
