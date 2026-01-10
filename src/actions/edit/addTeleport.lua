function addTeleportSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        if (menuVars.teleportBeforeHand) then
            noteOffset = noteOffset - 1 / getUsableDisplacementMultiplier(noteOffset)
        end
        local beforeDisplacement = nil
        local atDisplacement = displaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
