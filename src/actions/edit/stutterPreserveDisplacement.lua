function stutterPreserveDisplacementSVs(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if #offsets < 2 then return end

    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local originalFinalSV = game.get.svMultiplierAt(lastOffset)
    local svsToRemove = game.get.svsBetweenOffsets(firstOffset, lastOffset)
    local svsToAdd = {}
    local duration = math.clamp(menuVars.stutterDuration, 1, 99)

    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local timeInterval = endOffset - startOffset
        local originalSVs = game.get.svsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(originalSVs, startOffset)
        local originalDistance = calculateDisplacementFromSVs(originalSVs, startOffset, endOffset)
        local averageSV = originalDistance / timeInterval
        local stutterSVs = generateStutterSet(menuVars.startSV, duration, averageSV, menuVars.controlLastSV)
        local secondSVOffset = startOffset + timeInterval * duration * 0.01

        addSVToList(svsToAdd, startOffset, stutterSVs[1], true)
        addSVToList(svsToAdd, secondSVOffset, stutterSVs[2], true)
    end

    addFinalSV(svsToAdd, lastOffset, originalFinalSV)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
