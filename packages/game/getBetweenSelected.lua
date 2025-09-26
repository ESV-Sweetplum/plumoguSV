require("packages.table.dedupe")

---Finds and returns a list of all unique offsets of notes between selected notes [Table]
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetweenSelected(includeLN)
    local selectedNoteOffsets = game.uniqueSelectedNoteOffsets()
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
function game.uniqueSelectedNoteOffsets()
    local offsets = {}
    for _, ho in pairs(state.SelectedHitObjects) do
        table.insert(offsets, ho.StartTime)
        if (ho.EndTime ~= 0 and globalVars.useEndTimeOffsets) then table.insert(offsets, ho.EndTime) end
    end
    offsets = table.dedupe(offsets)
    offsets = sort(offsets, sortAscending)
    if (not truthy(offsets)) then return {} end
    return offsets
end

---Returns an array of hit objects within the selection time.
---@return HitObject[]
function game.uniqueNotesBetweenSelected()
    local selectedNoteOffsets = game.uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local hos = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (#hos < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return hos
end
