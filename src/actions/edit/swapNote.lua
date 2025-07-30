-- Swap selected notes' position with SVs
function swapNoteSVs()
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    local oldSVDisplacements = calculateDisplacementsFromSVs(svsBetweenOffsets, offsets)
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local currentDisplacement = oldSVDisplacements[i]
        local nextDisplacement = oldSVDisplacements[i + 1] or oldSVDisplacements[1]
        local newDisplacement = nextDisplacement - currentDisplacement

        local beforeDisplacement = newDisplacement
        local atDisplacement = -newDisplacement
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
