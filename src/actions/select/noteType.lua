---@diagnostic disable: undefined-field
function selectByNoteType(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]

    local totalNotes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then totalNotes = state.SelectedHitObjects end

    local notesToSelect = {}

    for _, note in ipairs(totalNotes) do
        if hitobject_type then
            if (note.Type == hitobject_type.Normal and not menuVars.normal) then
                goto skipType
            end
            if (note.Type == hitobject_type.Mine and not menuVars.mine) then
                goto skipType
            end
            if (note.EndTime == 0 and menuVars.rice) then table.insert(notesToSelect, note) end
            if (note.EndTime ~= 0 and menuVars.ln) then table.insert(notesToSelect, note) end
            ::skipType::
        else
            if (note.EndTime == 0 and menuVars.rice) then table.insert(notesToSelect, note) end
            if (note.EndTime ~= 0 and menuVars.ln) then table.insert(notesToSelect, note) end
        end
    end

    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
