function flickerSVs(menuVars)
    printLegacyLNMessage()
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local numTeleports = 2 * menuVars.numFlickers
    local isDelayedFlicker = FLICKER_TYPES[menuVars.flickerTypeIndex] == "Delayed"
    for i = 1, (#offsets - 1) do
        local flickerStartOffset = offsets[i]
        local flickerEndOffset = offsets[i + 1]
        local teleportOffsets = generateLinearSet(flickerStartOffset, flickerEndOffset,
            numTeleports + 1)
        local flickerDuration = teleportOffsets[2] - teleportOffsets[1]
        for t, _ in pairs(teleportOffsets) do
            if (t % 2 == 1) then goto continueTeleport end
            pushFactor = (2 * menuVars.flickerPosition - 1) * flickerDuration
            teleportOffsets[t] = teleportOffsets[t] + pushFactor
            ::continueTeleport::
        end
        for j = 1, numTeleports do
            local offsetIndex = j
            if isDelayedFlicker then offsetIndex = offsetIndex + 1 end
            local teleportOffset = math.floor(teleportOffsets[offsetIndex])
            local isTeleportBack = j % 2 == 0
            if isDelayedFlicker then
                local beforeDisplacement = menuVars.distance
                local atDisplacement = 0
                if isTeleportBack then beforeDisplacement = -beforeDisplacement end
                prepareDisplacingSVs(teleportOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
                    atDisplacement, 0)
            else
                local atDisplacement = menuVars.distance
                local afterDisplacement = 0
                if isTeleportBack then atDisplacement = -atDisplacement end
                prepareDisplacingSVs(teleportOffset, svsToAdd, svTimeIsAdded, nil, atDisplacement,
                    afterDisplacement)
            end
        end
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
