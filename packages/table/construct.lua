---Creates a new array with a custom metatable, allowing for `:` syntactic sugar.
---@param ... any entries to put into the table.
---@return table tbl A table with the given entries.
function table.construct(...)
    local tbl = {}
    for _, v in ipairs({ ... }) do
        table.insert(tbl, v)
    end
    setmetatable(tbl, { __index = table })
    return tbl
end

---Creates a new array with a custom metatable, allowing for `:` syntactic sugar. All elements will be the given item.
---@generic T: string | number | boolean | table
---@param item T The entry to use.
---@param num integer The number of entries to put into the table.
---@return T[] tbl A table with the given entries.
function table.constructRepeating(item, num)
    local tbl = table.construct()
    for _ = 1, num do
        table.insert(tbl, item)
    end
    return tbl
end
