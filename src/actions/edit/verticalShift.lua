function verticalShiftSVs(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not isTruthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(startOffset, endOffset)
    local svsBetweenOffsets = game.get.svsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    for _, sv in ipairs(svsBetweenOffsets) do
        local newSVMultiplier = sv.Multiplier + menuVars.verticalShift
        addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
