function placeSVs(menuVars, place, optionalStart, optionalEnd, optionalDistance, queuedSVs)
    local finalSVType = FINAL_SV_TYPES[menuVars.settingVars.finalSVIndex]
    local placingStillSVs = menuVars.noteSpacing ~= nil
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    if placingStillSVs then
        offsets = game.uniqueNoteOffsetsBetweenSelected()
        if (not truthy(offsets)) then return end
        if place == false then
            offsets = game.uniqueNoteOffsetsBetween(optionalStart, optionalEnd)
        end
    end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    if placingStillSVs then offsets = { firstOffset, lastOffset } end
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    if (not placingStillSVs) and globalVars.dontReplaceSV then
        svsToRemove = {}
    end
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local svOffsets = generateLinearSet(startOffset, endOffset, #menuVars.svDistances)
        for j = 1, #svOffsets - 1 do
            local offset = svOffsets[j]
            local multiplier = menuVars.svMultipliers[j]
            if optionalDistance ~= nil then
                multiplier = optionalDistance / (endOffset - startOffset) * math.abs(multiplier)
            end
            addSVToList(svsToAdd, offset, multiplier, true)
        end
    end
    local lastMultiplier = menuVars.svMultipliers[numMultipliers]
    if (place == nil or place == true) then
        if placingStillSVs then
            local tbl = getStillSVs(menuVars, firstOffset, lastOffset,
                sort(svsToAdd, sortAscendingStartTime), svsToAdd)
            svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
        end
        addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == "Override")
        removeAndAddSVs(svsToRemove, svsToAdd)
        return
    end
    local tbl = getStillSVs(menuVars, firstOffset, lastOffset,
        sort(svsToAdd, sortAscendingStartTime), svsToAdd, queuedSVs)
    svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
