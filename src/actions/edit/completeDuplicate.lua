function storeDuplicateItems(menuVars)
    objects = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    local tls = game.getLinesBetweenOffsets(startOffset, endOffset)
    local bms = game.getBookmarksBetweenOffsets(startOffset, endOffset)

    for _, note in pairs(notes) do
        table.insert(objects, { type = "ho", data = note })
    end
    for _, tl in pairs(tls) do
        table.insert(objects, { type = "tl", data = tl })
    end
    for _, bm in pairs(bms) do
        table.insert(objects, { type = "bm", data = bm })
    end

    local ogId = state.SelectedScrollGroupId
    local svTbl = {}
    local ssfTbl = {}
    for tgId, tg in pairs(map.TimingGroups) do
        svTbl[tgId] = {}
        ssfTbl[tgId] = {}
        state.SelectedScrollGroupId = tgId
        local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
        local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset)
        for _, sv in pairs(svs) do
            table.insert(svTbl[tgId], sv)
        end
        for _, ssf in pairs(ssfs) do
            table.insert(ssfTbl[tgId], ssf)
        end
    end

    state.SelectedScrollGroupId = ogId

    menuVars.objects = objects
    menuVars.svTbl = svTbl
    menuVars.ssfTbl = ssfTbl
    menuVars.msOffset = startOffset
end

function clearDuplicateItems(menuVars)
    menuVars.objects = {}
end

function placeDuplicateItems(menuVars)
    local placeTime = state.SelectedHitObjects[1].StartTime
    local hosToAdd = {}
    local tlsToAdd = {}
    local bmsToAdd = {}
    local svActions = {}
    local ssfActions = {}
    local moveActions = {}
    local objects = menuVars.objects
    local svTbl = menuVars.svTbl
    local ssfTbl = menuVars.ssfTbl
    local offset = placeTime - menuVars.msOffset
    for _, obj in ipairs(menuVars.objects) do
        local data = obj.data
        if (obj.type == "ho") then
            local ho = utils.CreateHitObject(data.StartTime + offset, data.Lane,
                data.EndTime == 0 and 0 or data.EndTime + offset, data.HitSound, data.EditorLayer)
            table.insert(hosToAdd, ho)
            table.insert(moveActions, createEA(action_type.MoveObjectsToTimingGroup, { ho }, data.TimingGroup))
        end
        if (obj.type == "tl") then
            table.insert(tlsToAdd, utils.CreateTimingPoint(data.StartTime + offset, data.Bpm, data.Signature, data
                .Hidden))
        end
        if (obj.type == "bm") then
            table.insert(bmsToAdd, utils.CreateBookmark(data.StartTime + offset, data.Note))
        end
    end
    for tgId, svList in pairs(svTbl) do
        local newSVList = {}
        for _, sv in pairs(svList) do
            table.insert(newSVList, createSV(sv.StartTime + offset, sv.Multiplier))
        end
        local tg = map.GetTimingGroup(tgId)
        table.insert(svActions, createEA(action_type.AddScrollVelocityBatch, newSVList, tg))
    end
    for tgId, ssfList in pairs(ssfTbl) do
        local newSSFList = {}
        for _, ssf in pairs(ssfList) do
            table.insert(newSSFList, createSSF(ssf.StartTime + offset, ssf.Multiplier))
        end
        local tg = map.GetTimingGroup(tgId)
        table.insert(ssfActions, createEA(action_type.AddScrollSpeedFactorBatch, newSSFList, tg))
    end

    actions.PerformBatch(table.combine({
        createEA(action_type.PlaceHitObjectBatch, hosToAdd),
        createEA(action_type.AddTimingPointBatch, tlsToAdd),
        createEA(action_type.AddBookmarkBatch, bmsToAdd),
    }, svActions, ssfActions))
    actions.PerformBatch(moveActions)
end
