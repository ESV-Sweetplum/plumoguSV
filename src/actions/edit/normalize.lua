function normalizeDisplaceSVs(menuVars)
    local makeupDistance = 0
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if not truthy(offsets) or #offsets < 2 then return end
    for i = 1, #offsets - 1 do
        local curOffset = offsets[i]
        local nextOffset = offsets[i + 1]

        local svsBetweenOffsets = game.get.svsBetweenOffsets(curOffset, nextOffset)
        local dist = calculateDisplacementFromSVs(svsBetweenOffsets, curOffset, nextOffset) or 0

        local displaceDistance = (nextOffset - curOffset) * menuVars.avgSV - dist + makeupDistance

        prepareDisplacingSVs(nextOffset, svsToAdd, svTimeIsAdded, displaceDistance, -displaceDistance, 0)

        makeupDistance = displaceDistance - makeupDistance
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, offsets[1], offsets[#offsets])
    removeAndAddSVs(svsToRemove, svsToAdd)
end
