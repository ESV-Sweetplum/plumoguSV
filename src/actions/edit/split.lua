function splitNotes(menuVars)
    local noteDict = {}
    local notes = state.SelectedHitObjects

    if (menuVars.modeIndex == 1) then
        for _, note in ipairs(notes) do
            if (noteDict[note.Lane]) then
                table.insert(noteDict[note.Lane], note)
            else
                noteDict[note.Lane] = { note }
            end
        end
    elseif (menuVars.modeIndex == 2) then
        for _, note in ipairs(notes) do
            if (noteDict[note.StartTime]) then
                table.insert(noteDict[note.StartTime], note)
            else
                noteDict[note.StartTime] = { note }
            end
        end
    else
        for _, note in ipairs(notes) do
            noteDict[note.StartTime .. "_" .. note.Lane] = { note }
        end
    end

    local prefix = "col"

    if (menuVars.modeIndex == 2) then
        prefix = "time"
    elseif (menuVars.modeIndex == 3) then
        prefix = "solo"
    end

    local editorActions = {}
    local existingIds = table.keys(map.TimingGroups)

    for name, noteList in pairs(noteDict) do
        local id = table.concat({ "splitter_", prefix, "_", name })
        local startTimeTbl = table.unpack(table.property(noteList, "StartTime"))
        local minStartTime = math.min(startTimeTbl)
        local maxStartTime = math.max(startTimeTbl)
        local svs = menuVars.cloneSVs and
            game.get.svsBetweenOffsets(minStartTime - menuVars.cloneRadius, maxStartTime + menuVars.cloneRadius) or {}
        if (not table.includes(existingIds, id)) then
            local tg = createSG(svs, 1, color.rgbaToStr(generateRGBColor(false)))
            local ea = createEA(action_type.CreateTimingGroup, id, tg, noteList)

            table.insert(editorActions, ea)
        else
            local ea = createEA(action_type.MoveObjectsToTimingGroup, noteList, id)
            local svEa = createEA(action_type.AddScrollVelocityBatch, svs, map.TimingGroups[id])
            table.insert(editorActions, ea)
            table.insert(editorActions, svEa)
        end
    end

    actions.PerformBatch(editorActions)
end
