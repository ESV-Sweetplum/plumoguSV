---Transforms an array element-wise using a given function.
---@generic T: string | number | boolean
---@generic U
---@param tbl T[]
---@param fn fun(element: T, idx?: number): U
---@return U[]
function table.map(tbl, fn)
    local newTbl = {}
    for idx, v in ipairs(tbl) do
        table.insert(newTbl, fn(v, idx))
    end

    return newTbl
end
