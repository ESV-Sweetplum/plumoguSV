---Transforms an array element-wise using a given function.
---@generic T: string | number | boolean
---@param tbl T[]
---@param fn fun(element: T): T
---@return T[]
function table.map(tbl, fn)
    local newTbl = {}
    for _, v in ipairs(tbl) do
        table.insert(newTbl, fn(v))
    end

    return newTbl
end
