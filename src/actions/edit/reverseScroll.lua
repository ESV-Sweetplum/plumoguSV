function reverseScrollSVs(menuVars)
    printLegacyLNMessage()
    local offsets = game.uniqueNoteOffsetsBetweenSelected(true)
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {}
    local almostSVsToAdd = {}
    local extraOffset = 2 / getUsableDisplacementMultiplier(endOffset)
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset + extraOffset)
    local svTimeIsAdded = {}
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    local sectionDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
    -- opposite-sign distances and displacements b/c flips SV multiplier signs at the end
    local msxSeparatingDistance = -10000
    local teleportDistance = -sectionDistance + msxSeparatingDistance
    local noteDisplacement = -menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = nil
        local atDisplacement = 0
        local afterDisplacement = 0
        if i ~= 1 then
            beforeDisplacement = noteDisplacement
            atDisplacement = -noteDisplacement
        end
        if i == 1 or i == #offsets then
            atDisplacement = atDisplacement + teleportDistance
        end
        prepareDisplacingSVs(noteOffset, almostSVsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    for _, sv in ipairs(svsBetweenOffsets) do
        if (not svTimeIsAdded[sv.StartTime]) then
            table.insert(almostSVsToAdd, sv)
        end
    end
    for _, sv in ipairs(almostSVsToAdd) do
        local newSVMultiplier = -sv.Multiplier
        if sv.StartTime > endOffset then newSVMultiplier = sv.Multiplier end
        addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
