require('packages.table.construct')
require('packages.table.dedupe')
---Returns a table of keys from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] keys A list of keys.
function table.keys(tbl)
    local resultsTbl = table.construct()

    for k, _ in pairs(tbl) do
        table.insert(resultsTbl, k)
    end

    return table.dedupe(resultsTbl)
end
