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
        menuVars.SVs = table.combine(menuVars.SVs, game.getSVsBetweenOffsets(startOffset, endOffset))
        menuVars.SSFs = table.combine(menuVars.SSFs, game.getSSFsBetweenOffsets(startOffset, endOffset))
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
    local svs = {}
    local ssfs = {}
    local bms = {}
    for _, ho in ipairs(menuVars.HOs) do
        table.insert(hos, utils.CreateHitObject(ho.StartTime, ho.Lane, ho.EndTime, ho.HitSounds, ho.EditorLayer))
    end
    for _, tl in ipairs(menuVars.TLs) do
        table.insert(tls, utils.CreateTimingPoint(tl.StartTime, tl.Bpm, tl.Signature, tl.Hidden))
    end
    for _, bm in ipairs(menuVars.BMs) do
        table.insert(bms, utils.CreateBookmark(bm.StartTime, bm.Note))
    end
    actions.PerformBatch({
        createEA(action_type.PlaceHitObjectBatch, hos),
        createEA(action_type.AddTimingPointBatch, tls),
        createEA(action_type.AddScrollVelocityBatch, svs),
        createEA(action_type.AddScrollSpeedFactorBatch, ssfs),
        createEA(action_type.AddBookmarkBatch, bms)
    })
end
