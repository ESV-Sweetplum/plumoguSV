function displaceNoteSVsParent(menuVars)
    printLegacyLNMessage()
    if (not menuVars.linearlyChange) then
        displaceNoteSVs(menuVars)
        return
    end
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local svsToRemove = {}
    local svsToAdd = {}

    for _, offset in ipairs(offsets) do
        local tbl = displaceNoteSVs(
            {
                distance = (offset - offsets[1]) / (offsets[#offsets] - offsets[1]) *
                    (menuVars.distance2 - menuVars.distance1) + menuVars.distance1
            },
            false, offset)
        svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
        svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    end

    removeAndAddSVs(svsToRemove, svsToAdd)
end

function displaceNoteSVs(menuVars, place, optionalOffset)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return { svsToRemove = {}, svsToAdd = {} } end
    if place == false then offsets = { optionalOffset } end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = displaceAmount
        local atDisplacement = -displaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    if place ~= false then
        removeAndAddSVs(svsToRemove, svsToAdd)
        return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
    end
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
