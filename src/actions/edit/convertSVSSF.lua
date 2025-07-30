function convertSVSSF(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local objects = {}
    local editorActions = {}

    if (menuVars.conversionDirection) then
        local svs = game.getSVsBetweenOffsets(startOffset, endOffset, false)
        for _, sv in ipairs(svs) do
            table.insert(objects, { StartTime = sv.StartTime, Multiplier = sv.Multiplier })
        end
        table.insert(editorActions, utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svs))
    else
        local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset, false)
        for _, ssf in ipairs(ssfs) do
            table.insert(objects, { StartTime = ssf.StartTime, Multiplier = ssf.Multiplier })
        end
        table.insert(editorActions, utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfs))
    end
    local createTable = {}
    for _, obj in ipairs(objects) do
        if (menuVars.conversionDirection) then
            table.insert(createTable, createSSF(obj.StartTime,
                obj.Multiplier))
        else
            table.insert(createTable, createSV(obj.StartTime, obj.Multiplier))
        end
    end
    if (menuVars.conversionDirection) then
        table.insert(editorActions, utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, createTable))
    else
        table.insert(editorActions, utils.CreateEditorAction(action_type.AddScrollVelocityBatch, createTable))
    end
    actions.PerformBatch(editorActions)
    toggleablePrint("w!", "Successfully converted.")
end
