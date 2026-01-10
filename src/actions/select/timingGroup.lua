function selectByTimingGroup(menuVars)
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notesToSelect = {}

    local notes = game.get.notesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end

    notes = sort(notes, sortAscendingNoteLaneTime)

    for _, note in pairs(notes) do
        if (note.TimingGroup == menuVars.designatedTimingGroup) then
            table.insert(notesToSelect, note)
        end
    end

    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
