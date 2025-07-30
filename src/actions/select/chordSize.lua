function selectByChordSizes(menuVars)
    local offsets = uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]

    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)

    local noteTimeTable = {}

    for _, note in ipairs(notes) do
        table.insert(noteTimeTable, note.StartTime)
    end

    noteTimeTable = table.dedupe(noteTimeTable)

    local sizeDict = {
        {},
        {},
        {},
        {}
    }

    for _, time in ipairs(noteTimeTable) do
        local size = 0
        local totalNotes = {}
        for _, note in ipairs(notes) do
            if (math.abs(note.StartTime - time) < 3) then
                size = size + 1
                table.insert(totalNotes, note)
            end
        end
        sizeDict[size] = table.combine(sizeDict[size], totalNotes)
    end

    local notesToSelect = {}

    if (menuVars.single) then notesToSelect = table.combine(notesToSelect, sizeDict[1]) end
    if (menuVars.jump) then notesToSelect = table.combine(notesToSelect, sizeDict[2]) end
    if (menuVars.hand) then notesToSelect = table.combine(notesToSelect, sizeDict[3]) end
    if (menuVars.quad) then notesToSelect = table.combine(notesToSelect, sizeDict[4]) end

    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
