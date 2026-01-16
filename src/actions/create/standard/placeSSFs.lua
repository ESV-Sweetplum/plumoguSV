function placeSSFs(menuVars)
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not isTruthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local ssfsToAdd = {}
    local ssfsToRemove = game.get.ssfsBetweenOffsets(firstOffset, lastOffset)
    if globalVars.dontReplaceSV then
        ssfsToRemove = {}
    end
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local ssfOffsets = generateLinearSet(startOffset, endOffset, #menuVars.svDistances)
        for j = 1, #ssfOffsets - 1 do
            local offset = ssfOffsets[j]
            local multiplier = menuVars.svMultipliers[j]
            addSSFToList(ssfsToAdd, offset, multiplier, true)
        end
    end
    local lastMultiplier = menuVars.svMultipliers[numMultipliers]
    addFinalSSF(ssfsToAdd, lastOffset, lastMultiplier)
    addInitialSSF(ssfsToAdd, firstOffset - 1 / getUsableDisplacementMultiplier(firstOffset))
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
end
