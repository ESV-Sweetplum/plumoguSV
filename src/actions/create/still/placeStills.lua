function placeStillSVsParent(menuVars)
    printLegacyLNMessage()
    local svsToRemove = {}
    local svsToAdd = {}
    if (menuVars.stillBehavior == 1) then
        if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and menuVars.settingVars.distanceMode == 2) then
            placeSVs(menuVars, nil, nil, nil, menuVars.settingVars.distance)
        else
            placeSVs(menuVars)
        end
        return
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    for i = 1, (#offsets - 1) do
        if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and menuVars.settingVars.distanceMode == 2) then
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1], menuVars.settingVars.distance, svsToAdd)
        else
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1], nil, svsToAdd)
        end
        svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
        svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    end
    addFinalSV(svsToAdd, offsets[#offsets], menuVars.svMultipliers[#menuVars.svMultipliers], true)
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function getStillSVs(menuVars, optionalStart, optionalEnd, svs, retroactiveSVRemovalTable, queuedSVs)
    local stillType = STILL_TYPES[menuVars.stillTypeIndex]
    local noteSpacing = menuVars.noteSpacing
    local stillDistance = menuVars.stillDistance
    local noteOffsets = game.uniqueNoteOffsetsBetween(optionalStart, optionalEnd, true)
    if (not noteOffsets) then return { svsToRemove = {}, svsToAdd = {} } end
    local firstOffset = noteOffsets[1]
    local lastOffset = noteOffsets[#noteOffsets]
    local svMultFn = truthy(queuedSVs) and function(t) return getHypotheticalSVMultiplierAt(queuedSVs, t) end or
        game.getSVMultiplierAt
    if stillType == "Auto" then
        local multiplier = getUsableDisplacementMultiplier(firstOffset)
        local duration = 1 / multiplier
        local timeBefore = firstOffset - duration
        multiplierBefore = svMultFn(timeBefore)
        stillDistance = multiplierBefore * duration
    elseif stillType == "Otua" then
        local multiplier = getUsableDisplacementMultiplier(lastOffset)
        local duration = 1 / multiplier
        local timeAt = lastOffset
        local multiplierAt = svMultFn(timeAt)
        stillDistance = -multiplierAt * duration
    end
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local svsBetweenOffsets = getHypotheticalSVsBetweenOffsets(svs, firstOffset, lastOffset)
    local svDisplacements = calculateDisplacementsFromSVs(svsBetweenOffsets, noteOffsets)
    local nsvDisplacements = calculateDisplacementsFromNotes(noteOffsets, noteSpacing)
    local finalDisplacements = calculateStillDisplacements(stillType, stillDistance,
        svDisplacements, nsvDisplacements)
    for i = 1, #noteOffsets do
        local noteOffset = noteOffsets[i]
        local beforeDisplacement = nil
        local atDisplacement = 0
        local afterDisplacement = nil
        if i ~= #noteOffsets then
            atDisplacement = -finalDisplacements[i]
            afterDisplacement = 0
        end
        if i ~= 1 then
            beforeDisplacement = finalDisplacements[i]
        end
        local baseSVs = table.duplicate(svs)
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement, true, baseSVs)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, firstOffset, lastOffset, retroactiveSVRemovalTable)
    while (svsToAdd[#svsToAdd].StartTime == optionalEnd) do
        table.remove(svsToAdd, #svsToAdd)
    end

    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
