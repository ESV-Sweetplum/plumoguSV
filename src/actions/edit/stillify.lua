function stillify(menuVars)
    local targetAverageSV = menuVars.avgSV
    local offsets = game.get.uniqueNoteOffsetsBetweenSelected()
    local startOffset, endOffset = offsets[1], offsets[#offsets]
    local temporalDistance = endOffset - startOffset

    local svs = game.get.svsBetweenOffsets(startOffset, endOffset)
    local svsToAdd = {}
    local svTimeIsAdded = {}
    local svsToRemove = {}

    local trueAverageSV = calculateDisplacementFromSVs(svs, startOffset, endOffset) / temporalDistance
    local firstNote = offsets[1]

    for i = 1, #offsets - 1 do
        local nextNote = offsets[i + 1]
        local regionSVs = game.get.svsBetweenOffsets(firstNote, nextNote)

        local targetDistance = (nextNote - firstNote) * targetAverageSV
        local currentDistance = calculateDisplacementFromSVs(regionSVs, firstNote, nextNote)

        -- If current > target, then the displacement should be negative to compesnate
        local displacementDistance = targetDistance - currentDistance
        prepareDisplacingSVs(
            nextNote,
            svsToAdd,
            svTimeIsAdded,
            displacementDistance,
            i == #offsets - 1 and 0 or -displacementDistance,
            i == #offsets - 1 and nil or 0
        )
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
