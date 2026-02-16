require('packages.table.duplicate')
---Concatenates arrays together.
---@param t1 any[] The first table.
---@param ... any[] The next tables.
---@return any[] tbl The resultant table.
function table.combine(t1, ...)
    local newTbl = table.duplicate(t1)
    for _, tbl in ipairs({ ... }) do
        for i = 1, #tbl do
            table.insert(newTbl, tbl[i])
        end
    end
    return newTbl
end
