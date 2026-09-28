function stutterPreserveDisplacementSVs(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if #offsets < 2 then return end

    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local originalFinalSV = game.get.svMultiplierAt(lastOffset)
    local svsToRemove = game.get.svsBetweenOffsets(firstOffset, lastOffset)
    local svsToAdd = {}
    local duration = math.clamp(menuVars.stutterDuration, 1, 99)
    local stuttersPerSection = math.floor(math.clamp(menuVars.stuttersPerSection or 1, 1, 1000))

    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local stutterOffsets = generateLinearSet(startOffset, endOffset, stuttersPerSection + 1)
        for j = 1, #stutterOffsets - 1 do
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local originalSVs = game.get.svsBetweenOffsets(stutterStart, stutterEnd)
            addStartSVIfMissing(originalSVs, stutterStart)
            local originalDistance = calculateDisplacementFromSVs(originalSVs, stutterStart, stutterEnd)
            local averageSV = originalDistance / timeInterval
            local stutterSVs = generateStutterSet(menuVars.startSV, duration, averageSV, menuVars.controlLastSV)
            local secondSVOffset = stutterStart + timeInterval * duration * 0.01

            addSVToList(svsToAdd, stutterStart, stutterSVs[1], true)
            addSVToList(svsToAdd, secondSVOffset, stutterSVs[2], true)
        end
    end

    addFinalSV(svsToAdd, lastOffset, originalFinalSV)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
