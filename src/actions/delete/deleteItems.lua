function deleteItems(menuVars)
    local offsets = uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local linesToRemove = game.getLinesBetweenOffsets(startOffset, endOffset)
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfsToRemove = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local bmsToRemove = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    if (not menuVars.deleteTable[1]) then linesToRemove = {} end
    if (not menuVars.deleteTable[2]) then svsToRemove = {} end
    if (not menuVars.deleteTable[3]) then ssfsToRemove = {} end
    if (not menuVars.deleteTable[4]) then bmsToRemove = {} end
    if (truthy(linesToRemove) or truthy(svsToRemove) or truthy(ssfsToRemove) or truthy(bmsToRemove)) then
        actions.PerformBatch({
            utils.CreateEditorAction(
                action_type.RemoveTimingPointBatch, linesToRemove),
            utils.CreateEditorAction(
                action_type.RemoveScrollVelocityBatch, svsToRemove),
            utils.CreateEditorAction(
                action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
            utils.CreateEditorAction(
                action_type.RemoveBookmarkBatch, bmsToRemove) })
    end
    if (truthy(#linesToRemove)) then
        toggleablePrint("e!", "Deleted " .. #linesToRemove .. pluralize(" timing point.", #linesToRemove, -2))
    end
    if (truthy(#svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(#ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(#bmsToRemove)) then
        toggleablePrint("e!", "Deleted " .. #bmsToRemove .. pluralize(" bookmark.", #bmsToRemove, -2))
    end
end
