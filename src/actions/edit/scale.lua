function scaleDisplaceSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local isStartDisplace = DISPLACE_SCALE_SPOTS[menuVars.scaleSpotIndex] == "Start"
    for i = 1, (#offsets - 1) do
        local note1Offset = offsets[i]
        local note2Offset = offsets[i + 1]
        local svsBetweenOffsets = game.get.svsBetweenOffsets(note1Offset, note2Offset)
        addStartSVIfMissing(svsBetweenOffsets, note1Offset)
        local scaleType = SCALE_TYPES[menuVars.scaleTypeIndex]
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, note1Offset,
            note2Offset)
        local scalingDistance
        if scaleType == "Average SV" then
            local targetDistance = menuVars.avgSV * (note2Offset - note1Offset)
            scalingDistance = targetDistance - currentDistance
            print(scalingDistance)
        elseif scaleType == "Absolute Distance" then
            scalingDistance = menuVars.distance - currentDistance
        elseif scaleType == "Relative Ratio" then
            scalingDistance = (menuVars.ratio - 1) * currentDistance
        end
        if isStartDisplace then
            prepareDisplacingSVs(note1Offset, svsToAdd, svTimeIsAdded, nil, scalingDistance,
                0)
        else
            prepareDisplacingSVs(note2Offset, svsToAdd, svTimeIsAdded, scalingDistance,
                0, nil)
        end
    end
    if isStartDisplace then addFinalSV(svsToAdd, endOffset, game.get.svMultiplierAt(endOffset)) end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function scaleMultiplySVs(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(offsets[1], offsets[#offsets])
    for i = 1, (#offsets - 1) do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local svsBetweenOffsets = game.get.svsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local scalingFactor = menuVars.ratio
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local scaleType = SCALE_TYPES[menuVars.scaleTypeIndex]
        if scaleType == "Average SV" then
            local currentAvgSV = currentDistance / (endOffset - startOffset)
            scalingFactor = menuVars.avgSV / currentAvgSV
        elseif scaleType == "Absolute Distance" then
            scalingFactor = menuVars.distance / currentDistance
        end
        for _, sv in ipairs(svsBetweenOffsets) do
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
