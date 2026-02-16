function convertSVSSF(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local objects = {}
    local editorActions = {}

    if (menuVars.conversionDirection) then
        local svs = game.get.svsBetweenOffsets(startOffset, endOffset, false)
        for _, sv in ipairs(svs) do
            table.insert(objects, { StartTime = sv.StartTime, Multiplier = sv.Multiplier })
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svs))
    else
        local ssfs = game.get.ssfsBetweenOffsets(startOffset, endOffset, false)
        for _, ssf in ipairs(ssfs) do
            table.insert(objects, { StartTime = ssf.StartTime, Multiplier = ssf.Multiplier })
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfs))
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
        table.insert(editorActions, createEA(action_type.AddScrollSpeedFactorBatch, createTable))
    else
        table.insert(editorActions, createEA(action_type.AddScrollVelocityBatch, createTable))
    end
    actions.PerformBatch(editorActions)
    toggleablePrint('s!', 'Successfully converted.')
end

function swapSVSSF(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToRemove = game.get.svsBetweenOffsets(startOffset, endOffset)
    local ssfsToRemove = game.get.ssfsBetweenOffsets(startOffset, endOffset)
    local svsToAdd = {}
    local ssfsToAdd = {}

    for _, sv in pairs(svsToRemove) do
        table.insert(ssfsToAdd, createSSF(sv.StartTime, sv.Multiplier))
    end

    for _, ssf in pairs(ssfsToRemove) do
        table.insert(svsToAdd, createSV(ssf.StartTime, ssf.Multiplier))
    end

    actions.PerformBatch({
        createEA(action_type.RemoveScrollVelocityBatch, svsToRemove),
        createEA(action_type.AddScrollVelocityBatch, svsToAdd),
        createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        createEA(action_type.AddScrollSpeedFactorBatch, ssfsToAdd),
    })

    toggleablePrint('s!', 'Successfully swapped.')
end
