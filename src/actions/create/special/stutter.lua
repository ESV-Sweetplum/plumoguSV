function placeStutterSVs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local lastFirstStutter = settingVars.startSV
    local lastMultiplier = settingVars.svMultipliers[3]
    if settingVars.linearlyChange then
        lastFirstStutter = settingVars.endSV
        lastMultiplier = settingVars.svMultipliers2[3]
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local totalNumStutters = (#offsets - 1) * settingVars.stuttersPerSection
    local firstStutterSVs = generateLinearSet(settingVars.startSV, lastFirstStutter,
        totalNumStutters)
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local stutterIndex = 1
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local stutterOffsets = generateLinearSet(startOffset, endOffset,
            settingVars.stuttersPerSection + 1)
        for j = 1, #stutterOffsets - 1 do
            local duration = settingVars.stutterDuration
            if settingVars.linearlyChange then
                local x = (i - 1) / (#stutterOffsets - 2)
                duration = x * settingVars.stutterDuration2 + (1 - x) * settingVars.stutterDuration
            end
            local svMultipliers = generateStutterSet(firstStutterSVs[stutterIndex],
                duration,
                settingVars.avgSV,
                settingVars.controlLastSV)
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local secondSVOffset = stutterStart + timeInterval * duration * 0.01
            addSVToList(svsToAdd, stutterStart, svMultipliers[1], true)
            addSVToList(svsToAdd, secondSVOffset, svMultipliers[2], true)
            stutterIndex = stutterIndex + 1
        end
    end
    addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function placeStutterSSFs(settingVars)
    local lastFirstStutter = settingVars.startSV
    local lastMultiplier = settingVars.svMultipliers[3]
    if settingVars.linearlyChange then
        lastFirstStutter = settingVars.endSV
        lastMultiplier = settingVars.svMultipliers2[3]
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local totalNumStutters = (#offsets - 1) * settingVars.stuttersPerSection
    local firstStutterSVs = generateLinearSet(settingVars.startSV, lastFirstStutter,
        totalNumStutters)
    local ssfsToAdd = {}
    local ssfsToRemove = game.getSSFsBetweenOffsets(firstOffset, lastOffset)
    local stutterIndex = 1
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local stutterOffsets = generateLinearSet(startOffset, endOffset,
            settingVars.stuttersPerSection + 1)
        for j = 1, #stutterOffsets - 1 do
            local ssfMultipliers = generateStutterSet(firstStutterSVs[stutterIndex],
                settingVars.stutterDuration,
                settingVars.avgSV,
                settingVars.controlLastSV)
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local secondSVOffset = stutterStart + timeInterval * settingVars.stutterDuration * 0.01
            addSSFToList(ssfsToAdd, stutterStart, ssfMultipliers[1], true)
            addSSFToList(ssfsToAdd, secondSVOffset, ssfMultipliers[2], true)
            stutterIndex = stutterIndex + 1
        end
    end
    addFinalSSF(ssfsToAdd, lastOffset, lastMultiplier)
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
end
