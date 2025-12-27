-- Calculates the total msx displacement over time for a given set of SVs
-- Returns a table of total displacements [Table]
-- Parameters
--    svs         : list of ordered svs to calculate displacement with [Table]
--    startOffset : starting time for displacement calculation [Int/Float]
--    endOffset   : ending time for displacement calculation [Int/Float]
function calculateDisplacementFromSVs(svs, startOffset, endOffset)
    return calculateDisplacementsFromSVs(svs, { startOffset, endOffset })[2]
end

-- Calculates the total msx displacements over time at offsets for a given set of SVs
-- Returns a table of total displacements [Table]
-- Parameters
--    svs     : list of ordered svs to calculate displacement with [Table]
--    offsets : list of offsets (milliseconds) to calculate displacement at [Table]
function calculateDisplacementsFromSVs(svs, offsets)
    local totalDisplacement = 0
    local displacements = {}
    local lastOffset = offsets[#offsets]
    addSVToList(svs, lastOffset, 0, true)
    local j = 1
    for i = 1, (#svs - 1) do
        local lastSV = svs[i]
        local nextSV = svs[i + 1]
        local svTimeDifference = nextSV.StartTime - lastSV.StartTime
        while nextSV.StartTime > offsets[j] do
            local svToOffsetTime = offsets[j] - lastSV.StartTime
            local displacement = totalDisplacement
            if svToOffsetTime > 0 then
                displacement = displacement + lastSV.Multiplier * svToOffsetTime
            end
            table.insert(displacements, displacement)
            j = j + 1
        end
        if svTimeDifference > 0 then
            local thisDisplacement = svTimeDifference * lastSV.Multiplier
            totalDisplacement = totalDisplacement + thisDisplacement
        end
    end
    table.remove(svs)
    table.insert(displacements, totalDisplacement)
    return displacements
end
