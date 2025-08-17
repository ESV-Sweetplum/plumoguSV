---Returns a copy of a table containing all values between indices `i` and `j` (inclusive). If `j` is not passed in, will slice to the end of the table.
---@generic T
---@param tbl T[]
---@param i integer
---@param j? integer
---@return T[]
function table.slice(tbl, i, j)
    return { table.unpack(tbl, i, j or #tbl) }
end
