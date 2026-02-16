require('packages.table.average')
require('packages.table.construct')
---Normalizes a table of numbers to achieve a target average.
---@param values number[] The table to normalize.
---@param targetAverage number The desired average value.
---@param includeLastValue boolean Whether or not to include the last value in the average.
---@return number[]
function table.normalize(values, targetAverage, includeLastValue)
    local avgValue = table.average(values, includeLastValue)
    if avgValue == 0 then return table.constructRepeating(0, #values) end
    local newValues = {}
    for i = 1, #values do
        table.insert(newValues, (values[i] * targetAverage) / avgValue)
    end

    return newValues
end
