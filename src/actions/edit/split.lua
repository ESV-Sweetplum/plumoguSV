function splitNotes(menuVars)
    local noteDict = {}
    local notes = state.SelectedHitObjects

    if (menuVars.modeIndex == 1) then
        for i = 1, game.keyCount do
            noteDict[i] = {}
        end
        for _, note in ipairs(notes) do
            table.insert(noteDict[note.Lane], note)
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
        if (not table.includes(existingIds, id)) then
            local tg = createSG({}, 1, color.rgbaToStr(generateColor(false)))
            local ea = createEA(action_type.CreateTimingGroup, id, tg, noteList)

            table.insert(editorActions, ea)
        else
            local ea = createEA(action_type.MoveObjectsToTimingGroup, noteList, id)

            table.insert(editorActions, ea)
        end
    end

    actions.PerformBatch(editorActions)
end
