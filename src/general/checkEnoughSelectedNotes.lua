---Returns `true` if enough notes are selected.
---@param minimumNotes 0|1|2
---@return boolean
function checkEnoughSelectedNotes(minimumNotes)
    if minimumNotes == 0 then return true end
    local selectedNotes = state.SelectedHitObjects
    local numSelectedNotes = #selectedNotes
    if numSelectedNotes == 0 then return false end
    if minimumNotes == 1 then return true end
    if numSelectedNotes > game.keyCount then return true end
    if (globalVars.useEndTimeOffsets and minimumNotes == 2 and selectedNotes[1].EndTime ~= 0) then return true end
    return selectedNotes[1].StartTime ~= selectedNotes[numSelectedNotes].StartTime
end
