function selectByChordSizes(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not isTruthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]

    local notes = game.get.notesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end

    notes = sort(notes, sortAscendingNoteLaneTime)

    local noteTimeTable = {}

    for _, note in ipairs(notes) do
        table.insert(noteTimeTable, note.StartTime)
    end

    noteTimeTable = table.dedupe(noteTimeTable)

    local sizeDict = {}

    for idx = 1, game.keyCount do
        table.insert(sizeDict, {})
    end

    -- local allowedOrdering = {}

    -- for n in tostring(menuVars.laneSelector):gmatch("%d") do
    --     table.insert(allowedOrdering, tn(n))
    -- end

    for _, time in ipairs(noteTimeTable) do
        local size = 0
        local curLane = 0
        local totalNotes = {}
        for _, note in ipairs(notes) do
            if (math.abs(note.StartTime - time) < 3) then
                size = size + 1
                curLane = curLane + 1
                -- if (table.contains(allowedOrdering, curLane)) then
                table.insert(totalNotes, note)
                -- end
            end
        end
        sizeDict[size] = table.combine(sizeDict[size], totalNotes)
    end

    local notesToSelect = {}

    for idx = 1, game.keyCount do
        if (menuVars["select" .. idx]) then
            notesToSelect = table.combine(notesToSelect, sizeDict[idx])
        end
    end

    actions.SetHitObjectSelection(notesToSelect)
    print(isTruthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
