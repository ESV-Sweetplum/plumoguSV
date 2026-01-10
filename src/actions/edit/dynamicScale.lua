function dynamicScaleSVs(menuVars)
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
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
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
