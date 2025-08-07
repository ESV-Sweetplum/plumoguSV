function selectAlternating(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    local times = {}
    for _, ho in ipairs(notes) do
        table.insert(times, ho.StartTime)
    end
    times = table.dedupe(times)
    local allowedTimes = {}
    for i, time in pairs(times) do
        if ((i - 2 + menuVars.offset) % menuVars.every == 0) then
            table.insert(allowedTimes, time)
        end
    end
    local notesToSelect = {}
    local currentTime = allowedTimes[1]
    local index = 2
    for _, note in ipairs(notes) do
        if (note.StartTime > currentTime and index <= #allowedTimes) then
            currentTime = allowedTimes[index]
            index = index + 1
        end
        if (note.StartTime == currentTime) then
            table.insert(notesToSelect, note)
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
