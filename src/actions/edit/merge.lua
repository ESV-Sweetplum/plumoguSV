function mergeSVs()
    local offsets = uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svTimeDict = {}
    local svsToRemove = {}
    for _, sv in ipairs(table.reverse(game.getSVsBetweenOffsets(startOffset, endOffset, true, true))) do -- reverse to prioritize second sv in list
        if (svTimeDict[sv.StartTime]) then
            table.insert(svsToRemove, sv)
        else
            svTimeDict[sv.StartTime] = true
        end
    end

    actions.Perform(utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove))
end
