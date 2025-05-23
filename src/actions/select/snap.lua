function selectBySnap(menuVars)
    local offsets = uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = getNotesBetweenOffsets(startOffset, endOffset)

    local timingPoint = getTimingPointAt(startOffset)
    local bpm = timingPoint.Bpm
    local times = {}
    local disallowedTimes = {}
    local pointer = timingPoint.StartTime
    local counter = 0

    local factors = {}

    for i = 2, (menuVars.snap - 1) do
        if (menuVars.snap % i == 0) then table.insert(factors, i) end
    end

    for _, factor in pairs(factors) do
        while (pointer <= endOffset + 10) do
            if ((counter ~= 0 or factor == 1) and pointer >= startOffset) then table.insert(disallowedTimes, pointer) end
            counter = (counter + 1) % factor
            pointer = pointer + (60000 / bpm) / (factor)
        end
        pointer = timingPoint.StartTime
        counter = 0
    end

    while (pointer <= endOffset + 10) do
        if ((counter ~= 0 or menuVars.snap == 1) and pointer >= startOffset) then table.insert(times, pointer) end
        counter = (counter + 1) % menuVars.snap
        pointer = pointer + (60000 / bpm) / (menuVars.snap)
    end

    for _, bannedTime in pairs(disallowedTimes) do
        for idx, time in pairs(times) do
            if (math.abs(time - bannedTime) < 10) then table.remove(times, idx) end
        end
    end

    local notesToSelect = {}
    local currentTime = times[1]
    local index = 2
    for _, note in pairs(notes) do
        if (note.StartTime > currentTime + 10 and index <= #times) then
            currentTime = times[index]
            index = index + 1
        end
        if (math.abs(note.StartTime - currentTime) < 10) then
            table.insert(notesToSelect, note)
        end
    end

    actions.SetHitObjectSelection(notesToSelect)
    print(#notesToSelect > 0 and "S!" or "W!", #notesToSelect .. " notes selected")
end
