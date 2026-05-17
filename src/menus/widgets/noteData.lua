function renderNoteDataWidget()
    if (#state.SelectedHitObjects ~= 1) then return end
    imgui.BeginTooltip()
    imgui.Text('Note Info:')
    local selectedNote = state.SelectedHitObjects[1]
    imgui.Text('StartTime = ' .. selectedNote.StartTime .. ' ms')
    local noteIsNotLN = selectedNote.EndTime == 0
    if noteIsNotLN then
        imgui.EndTooltip()
        return
    end

    local lnLength = selectedNote.EndTime - selectedNote.StartTime
    imgui.Text('EndTime = ' .. selectedNote.EndTime .. ' ms')
    imgui.Text('LN Length = ' .. lnLength .. ' ms')
    imgui.EndTooltip()
end
