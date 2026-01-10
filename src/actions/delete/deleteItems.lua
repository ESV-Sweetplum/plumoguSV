function deleteItems(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local linesToRemove = game.get.linesBetweenOffsets(startOffset, endOffset)
    local svsToRemove = game.get.svsBetweenOffsets(startOffset, endOffset)
    local ssfsToRemove = game.get.ssfsBetweenOffsets(startOffset, endOffset)
    local bmsToRemove = game.get.bookmarksBetweenOffsets(startOffset, endOffset)
    if (not menuVars.deleteTable[1]) then linesToRemove = {} end
    if (not menuVars.deleteTable[2]) then svsToRemove = {} end
    if (not menuVars.deleteTable[3]) then ssfsToRemove = {} end
    if (not menuVars.deleteTable[4]) then bmsToRemove = {} end
    if (truthy(linesToRemove) or truthy(svsToRemove) or truthy(ssfsToRemove) or truthy(bmsToRemove)) then
        actions.PerformBatch({
            createEA(
                action_type.RemoveTimingPointBatch, linesToRemove),
            createEA(
                action_type.RemoveScrollVelocityBatch, svsToRemove),
            createEA(
                action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
            createEA(
                action_type.RemoveBookmarkBatch, bmsToRemove) })
    end
    if (truthy(linesToRemove)) then
        toggleablePrint("e!", "Deleted " .. #linesToRemove .. pluralize(" timing point.", #linesToRemove, -2))
    end
    if (truthy(svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(bmsToRemove)) then
        toggleablePrint("e!", "Deleted " .. #bmsToRemove .. pluralize(" bookmark.", #bmsToRemove, -2))
    end
end
