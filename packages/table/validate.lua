require("packages.table.keys")
require("packages.table.contains")
---When given a dictionary and table of keys, returns a new table with only the specified keys and values.
---@generic T table
---@param checkList T The base table, which has a list of keys to include in the new table.
---@param tbl T The base table in which to lint the data from.
---@param extrapolateData? boolean If this is set to true, will fill in missing keys in the new table with values frmo the old table.
---@param inferTypes? boolean If true, this will try to coerce types from `tbl` into the types of `checkList`.
---@return T outputTable
function table.validate(checkList, tbl, extrapolateData, inferTypes)
    local validKeys = table.keys(checkList)
    local tableKeys = table.keys(tbl)
    local outputTable = {}
    for _, key in ipairs(validKeys) do
        if (table.contains(tableKeys, key)) then
            outputTable[key] = tbl[key]
        end
        if (not table.contains(tableKeys, key) and extrapolateData) then
            outputTable[key] = checkList[key]
        end
        if (inferTypes and outputTable[key]) then
            outputTable[key] = parseProperty(outputTable[key], checkList[key]) or outputTable[key]
        end
    end
    return outputTable
end
