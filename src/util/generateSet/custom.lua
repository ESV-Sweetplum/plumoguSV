-- Returns a set of custom values [Table]
-- Parameters
--    values : list of custom values [Table]
function generateCustomSet(values)
    local newValues = table.duplicate(values)
    local averageMultiplier = table.average(newValues, true)
    table.insert(newValues, averageMultiplier)
    return newValues
end
