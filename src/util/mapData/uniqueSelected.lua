---Finds and returns a list of all unique offsets of notes between selected notes [Table]
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetweenSelected(includeLN)
    local selectedNoteOffsets = uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local offsets = game.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    if (#offsets < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return offsets
end

---Returns a list of unique offsets (in increasing order) of selected notes [Table]
---@return number[]
function uniqueSelectedNoteOffsets()
    local offsets = {}
    for i, ho in pairs(state.SelectedHitObjects) do
        offsets[i] = ho.StartTime
    end
    offsets = table.dedupe(offsets)
    offsets = sort(offsets, sortAscending)
    if (#offsets == 0) then return {} end
    return offsets
end

function uniqueNotesBetweenSelected()
    local selectedNoteOffsets = uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local offsets = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (#offsets < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return offsets
end
