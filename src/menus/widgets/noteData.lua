function renderNoteDataWidget()
    if (#state.SelectedHitObjects ~= 1) then return end
    imgui.BeginTooltip()
    imgui.Text(("Note Info:"):obfuscate())
    local selectedNote = state.SelectedHitObjects[1]
    imgui.Text(("StartTime = " .. selectedNote.StartTime .. " ms"):obfuscate())
    local noteIsNotLN = selectedNote.EndTime == 0
    if noteIsNotLN then
        imgui.EndTooltip()
        return
    end

    local lnLength = selectedNote.EndTime - selectedNote.StartTime
    imgui.Text(("EndTime = " .. selectedNote.EndTime .. " ms"):obfuscate())
    imgui.Text(("LN Length = " .. lnLength .. " ms"):obfuscate())
    imgui.EndTooltip()
end
