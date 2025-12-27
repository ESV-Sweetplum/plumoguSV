---Returns a 1-indexed value corresponding to the location of an element within a table.
---@param tbl table The table to search in.
---@param item any The item to search for.
---@return integer idx The index of the item. If the item doesn't exist, returns -1 instead.
function table.indexOf(tbl, item)
    for i, v in pairs(tbl) do
        if v == item then return i end
    end
    return -1
end
