-- Checks to see if enough notes are selected (ONLY works for minimumNotes = 0, 1, or 2)
-- Returns whether or not there are enough notes [Boolean]
-- Parameters
--    minimumNotes : minimum number of notes needed to be selected [Int]
function checkEnoughSelectedNotes(minimumNotes)
    if minimumNotes == 0 then return true end
    local selectedNotes = state.SelectedHitObjects
    local numSelectedNotes = #selectedNotes
    if numSelectedNotes == 0 then return false end
    if minimumNotes == 1 then return true end
    if numSelectedNotes > game.keyCount then return true end
    return selectedNotes[1].StartTime ~= selectedNotes[numSelectedNotes].StartTime
end
