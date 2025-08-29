---Returns the average value of an array.
---@param values number[] The list of numbers.
---@param includeLastValue? boolean Whether or not to include the last value in the table.
---@return number avg The arithmetic mean of the table.
function table.average(values, includeLastValue)
    if not truthy(values) then return 0 end
    local sum = 0
    for _, value in ipairs(values) do
        sum = sum + value
    end
    if not includeLastValue then
        sum = sum - values[#values]
        return sum / (#values - 1)
    end
    return sum / #values
end
