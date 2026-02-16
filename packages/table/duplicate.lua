require('packages.table.keys')
---Returns a deep copy of a table.
---@generic T : table
---@param tbl T The original table.
---@return T tbl The new table.
function table.duplicate(tbl)
    if not tbl then return {} end
    local dupeTbl = {}
    if (tbl[1]) then
        for _, value in ipairs(tbl) do
            table.insert(dupeTbl, type(value) == 'table' and table.duplicate(value) or value)
        end
    else
        for _, key in ipairs(table.keys(tbl)) do
            local value = tbl[key]
            dupeTbl[key] = type(value) == 'table' and table.duplicate(value) or value
        end
    end
    return dupeTbl
end
