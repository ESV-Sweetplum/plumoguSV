require("packages.table.dedupe")
require("packages.table.sort")

---Finds and returns a list of all unique offsets of notes between selected notes [Table]
---@param includeLN? boolean
---@return number[]
function game.get.uniqueNoteOffsetsBetweenSelected(includeLN)
    local selectedNoteOffsets = game.get.uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local offsets = game.get.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    if (#offsets < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return offsets
end

---Returns a list of unique offsets (in increasing order) of selected notes [Table]
---@return number[]
function game.get.uniqueSelectedNoteOffsets()
    local offsets = {}
    for _, ho in pairs(state.SelectedHitObjects) do
        table.insert(offsets, ho.StartTime)
        if (ho.EndTime ~= 0 and globalVars.useEndTimeOffsets) then table.insert(offsets, ho.EndTime) end
    end
    if (not isTruthy(offsets)) then return {} end
    offsets = table.dedupe(offsets)
    offsets = sort(offsets, sortAscending)
    return offsets
end

---Returns an array of hit objects within the selection time.
---@return HitObject[]
function game.get.uniqueNotesBetweenSelected()
    local selectedNoteOffsets = game.get.uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local hos = game.get.notesBetweenOffsets(startOffset, endOffset)
    if (#hos < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return hos
end

---Finds and returns a list of all unique offsets of notes between a start and an end time [Table]
---@param startOffset number
---@param endOffset number
---@param includeLN? boolean
---@return number[]
function game.get.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    local noteOffsetsBetween = {}
    includeLN = includeLN or globalVars.useEndTimeOffsets
    for _, ho in ipairs(map.HitObjects) do
        if ho.StartTime >= startOffset and ho.StartTime <= endOffset then
            local skipNote = false
            if (state.SelectedScrollGroupId ~= ho.TimingGroup and globalVars.ignoreNotesOutsideTg) then skipNote = true end
            if (ho.StartTime == startOffset or ho.StartTime == endOffset) then skipNote = false end

            if skipNote then goto nextNote end
            table.insert(noteOffsetsBetween, ho.StartTime)
            if (ho.EndTime ~= 0 and ho.EndTime <= endOffset and includeLN) then
                table.insert(noteOffsetsBetween,
                    ho.EndTime)
            end
            ::nextNote::
        end
        if ho.EndTime >= startOffset and ho.EndTime <= endOffset and includeLN then
            table.insert(noteOffsetsBetween, ho.EndTime)
        end
    end
    noteOffsetsBetween = table.dedupe(noteOffsetsBetween)
    noteOffsetsBetween = sort(noteOffsetsBetween, sortAscending)
    return noteOffsetsBetween
end
