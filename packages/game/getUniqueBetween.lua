require("packages.table.dedupe")

---Finds and returns a list of all unique offsets of notes between a start and an end time [Table]
---@param startOffset number
---@param endOffset number
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    local noteOffsetsBetween = {}
    includeLN = includeLN or globalVars.useEndTimeOffsets
    for _, ho in ipairs(map.HitObjects) do
        if ho.StartTime >= startOffset and ho.StartTime <= endOffset then
            local skipNote = false
            if (state.SelectedScrollGroupId ~= ho.TimingGroup and globalVars.ignoreNotesOutsideTg) then skipNote = true end
            if (ho.StartTime == startOffset or ho.StartTime == endOffset) then skipNote = false end

            if (skipNote) then goto skip end
            table.insert(noteOffsetsBetween, ho.StartTime)
            if (ho.EndTime ~= 0 and ho.EndTime <= endOffset and includeLN) then
                table.insert(noteOffsetsBetween,
                    ho.EndTime)
            end
            ::skip::
        end
        if ho.EndTime >= startOffset and ho.EndTime <= endOffset and includeLN then
            table.insert(noteOffsetsBetween, ho.EndTime)
        end
    end
    noteOffsetsBetween = table.dedupe(noteOffsetsBetween)
    noteOffsetsBetween = sort(noteOffsetsBetween, sortAscending)
    return noteOffsetsBetween
end

game.getUniqueNoteOffsetsBetween = game.uniqueNoteOffsetsBetween
