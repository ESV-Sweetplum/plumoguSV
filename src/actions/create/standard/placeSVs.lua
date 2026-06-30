function placeSVs(menuVars, place, optionalStart, optionalEnd, optionalDistance, queuedSVs)
    local finalSVType = FINAL_SV_TYPES[menuVars.settingVars.finalSVIndex]
    local placingStillSVs = menuVars.noteSpacing ~= nil
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if not truthy(offsets) then return end
    if placingStillSVs then
        offsets = game.get.uniqueNoteOffsetsBetweenSelected()
        if not truthy(offsets) then return end
        if place == false then offsets = game.get.uniqueNoteOffsetsBetween(optionalStart, optionalEnd) end
    end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    if placingStillSVs then offsets = { firstOffset, lastOffset } end
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(firstOffset, lastOffset, finalSVType == 'Override')
    if (not placingStillSVs) and globalVars.dontReplaceSV then svsToRemove = {} end
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
    if place == nil or place == true then
        if placingStillSVs then
            local stillSVResult =
                getStillSVs(menuVars, firstOffset, lastOffset, sort(svsToAdd, sortAscendingStartTime), svsToAdd)
            svsToAdd = table.combine(svsToAdd, stillSVResult.svsToAdd)
        end
        if finalSVType ~= 'None' then addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == 'Override') end
        queue.add({ rSVs = svsToRemove, aSVs = svsToAdd })
        queue.execute() -- Eventually fix svs to add not being able to be added in correct tg
        return
    end
    local stillSVResult =
        getStillSVs(menuVars, firstOffset, lastOffset, sort(svsToAdd, sortAscendingStartTime), svsToAdd, queuedSVs)

    queue.add({ rSVs = svsToRemove, aSVs = svsToAdd })
    queue.add({ aSVs = stillSVResult.svsToAdd })
end
