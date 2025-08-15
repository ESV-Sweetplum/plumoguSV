require("packages.table.construct")
---Returns a table of values from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] values A list of values.
function table.values(tbl)
    local resultsTbl = table.construct()

    for _, v in ipairs(tbl) do
        table.insert(resultsTbl, v)
    end

    return resultsTbl
end
