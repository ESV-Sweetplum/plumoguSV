---When given a dictionary and table of keys, returns a new table with only the specified keys and values.
---@param checkList { [string]: any } The base table, which has a list of keys to include in the new table.
---@param tbl { [string]: any } The base table in which to lint the data from.
---@param extrapolateData? boolean If this is set to true, will fill in missing keys in the new table with values frmo the old table.
---@return { [string]: any } outputTable
function table.validate(checkList, tbl, extrapolateData)
    local validKeys = table.keys(checkList)
    local tableKeys = table.keys(tbl)
    local outputTable = table.construct()
    for _, key in pairs(validKeys) do
        if (table.contains(tableKeys, key)) then
            outputTable[key] = tbl[key]
        end
        if (not table.contains(tableKeys, key) and extrapolateData) then
            outputTable[key] = checkList[key]
        end
    end
    return outputTable
end
