-- Calculates the total msx displacements over time at offsets
-- Returns a table of total displacements [Table]
-- Parameters
--    noteOffsets : list of offsets (milliseconds) to calculate displacement at [Table]
--    noteSpacing : SV multiplier determining spacing [Int/Float]
function calculateDisplacementsFromNotes(noteOffsets, noteSpacing)
    local totalDisplacement = 0
    local displacements = { 0 }
    for i = 1, #noteOffsets - 1 do
        local time = (noteOffsets[i + 1] - noteOffsets[i])
        local distance = time * noteSpacing
        totalDisplacement = totalDisplacement + distance
        table.insert(displacements, totalDisplacement)
    end
    return displacements
end
