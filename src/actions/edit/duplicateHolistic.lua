function instanceItems(menuVars)
    clearInstance(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    menuVars.HOs = game.getNotesBetweenOffsets(startOffset, endOffset)
    menuVars.TLs = game.getLinesBetweenOffsets(startOffset, endOffset)
    menuVars.BMs = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    local ogTgId = state.SelectedScrollGroupId
    for tgId, _ in pairs(map.TimingGroups) do
        state.SelectedScrollGroupId = tgId
        menuVars.SVs[tgId] = {}
        menuVars.SSFs[tgId] = {}
        menuVars.SVs[tgId] = table.combine(menuVars.SVs[tgId], game.getSVsBetweenOffsets(startOffset, endOffset))
        menuVars.SSFs[tgId] = table.combine(menuVars.SSFs[tgId], game.getSSFsBetweenOffsets(startOffset, endOffset))
        table.insert(menuVars.instanceTGIds, tgId)
    end
    state.SelectedScrollGroupId = ogTgId
    menuVars.instanceStartTime = startOffset
end

function clearInstance(menuVars)
    menuVars.HOs = {}
    menuVars.TLs = {}
    menuVars.SVs = {}
    menuVars.SSFs = {}
    menuVars.BMs = {}
    menuVars.instanceTGIds = {}
    menuVars.instanceStartTime = 0
end

function pasteInstance(menuVars)
    local offset = state.SongTime - menuVars.instanceStartTime
    local hos = {}
    local tls = {}
    local bms = {}
    local ogTgId = state.SelectedScrollGroupId
    for _, ho in ipairs(menuVars.HOs) do
        table.insert(hos, utils.CreateHitObject(offset + ho.StartTime, ho.Lane, ho.EndTime, ho.HitSound, ho.EditorLayer))
    end
    for _, tl in ipairs(menuVars.TLs) do
        table.insert(tls, utils.CreateTimingPoint(offset + tl.StartTime, tl.Bpm, tl.Signature, tl.Hidden))
    end
    for _, bm in ipairs(menuVars.BMs) do
        table.insert(bms, utils.CreateBookmark(offset + bm.StartTime, bm.Note))
    end
    actions.PerformBatch({
        createEA(action_type.PlaceHitObjectBatch, hos),
        createEA(action_type.AddTimingPointBatch, tls),
        createEA(action_type.AddBookmarkBatch, bms)
    })
    local actionList = {}

    for tgId, tgSVs in pairs(menuVars.SVs) do
        state.SelectedScrollGroupId = tgId
        local svs = {}
        for _, sv in ipairs(tgSVs) do
            table.insert(svs, createSV(offset + sv.StartTime, sv.Multiplier))
        end
        actionList[tgId] = {}
        table.insert(actionList[tgId], createEA(action_type.AddScrollVelocityBatch, svs))
    end
    for tgId, tgSSFs in pairs(menuVars.SSFs) do
        state.SelectedScrollGroupId = tgId
        local ssfs = {}
        for _, ssf in ipairs(tgSSFs) do
            table.insert(ssfs, createSSF(offset + ssf.StartTime, ssf.Multiplier))
        end
        if (not truthy(actionList[tgId])) then actionList[tgId] = {} end
        table.insert(actionList[tgId], createEA(action_type.AddScrollSpeedFactorBatch, ssfs))
    end
    local svSSFActionCount = 0
    for tgId, subActionList in pairs(actionList) do
        state.SelectedScrollGroupId = tgId
        actions.PerformBatch(subActionList)
        svSSFActionCount = svSSFActionCount + 1
    end
    state.SelectedScrollGroupId = ogTgId
    local actionCount = svSSFActionCount + 1
    print("w!", "Pasted. This action requires " .. actionCount .. pluralize(" undo.", actionCount, -2))
end
