-- Calculates still displacements
-- Returns the still displacements [Table]
-- Parameters
--    stillType        : type of still [String]
--    stillDistance    : distance of the still according to the still type [Int/Float]
--    svDisplacements  : list of displacements of notes based on svs [Table]
--    nsvDisplacements : list of displacements of notes based on notes only, no sv [Table]
function calculateStillDisplacements(stillType, stillDistance, svDisplacements, nsvDisplacements)
    local finalDisplacements = {}
    for i = 1, #svDisplacements do
        local difference = nsvDisplacements[i] - svDisplacements[i]
        table.insert(finalDisplacements, difference)
    end
    local extraDisplacement = stillDistance
    if stillType == "End" or stillType == "Otua" then
        extraDisplacement = stillDistance - finalDisplacements[#finalDisplacements]
    end
    if stillType ~= "No" then
        for i = 1, #finalDisplacements do
            finalDisplacements[i] = finalDisplacements[i] + extraDisplacement
        end
    end
    return finalDisplacements
end
