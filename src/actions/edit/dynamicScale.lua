function dynamicScaleSVsParent(menuVars)
    if menuVars.scaleTypeIndex == 1 then
        dynamicScaleNoteSVs(menuVars)
        return
    else
        dynamicScaleSVSVs(menuVars)
    end
end

function dynamicScaleNoteSVs(menuVars)
    local offsets = menuVars.noteTimes
    local targetAvgSVs = menuVars.svMultipliers
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(offsets[1], offsets[#offsets])
    for i = 1, (#offsets - 1) do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local targetAvgSV = targetAvgSVs[i]
        local svsBetweenOffsets = game.get.svsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
        --[[
        local currentAvgSV = currentDistance / (endOffset - startOffset)
        local scalingFactor = targetAvgSV / currentAvgSV
        --]]
        local targetDistance = targetAvgSV * (endOffset - startOffset)
        local scalingFactor = targetDistance / currentDistance
        for _, sv in ipairs(svsBetweenOffsets) do
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function dynamicScaleSVSVs(menuVars)
    local progressionTable = {}
    for i = 0, #menuVars.svMultipliers - 1 do
        table.insert(progressionTable, i / (#menuVars.svMultipliers - 1))
    end
    local offsets = game.get.uniqueNoteOffsetsBetweenSelected()
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local currentProgression = 0
    local currentIndex = 1
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(firstOffset, lastOffset)
    for i = 1, #svsToRemove do
        local curTime = svsToRemove[i].StartTime
        local x = (curTime - firstOffset) / (lastOffset - firstOffset)
        while currentProgression < x do
            currentIndex = currentIndex + 1
            currentProgression = progressionTable[currentIndex]
        end
        currentIndex = math.min(currentIndex, #progressionTable - 1)
        local startValue, endValue = menuVars.svMultipliers[currentIndex], menuVars.svMultipliers[currentIndex + 1]
        local trueMult = math.map(firstOffset, lastOffset, curTime, startValue, endValue)
        table.insert(svsToAdd, utils.CreateScrollVelocity(curTime, trueMult * svsToRemove[i].Multiplier))
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
