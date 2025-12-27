---Returns a boolean value corresponding to whether or not an element exists within a table.
---@param tbl any[] The table to search in.
---@param item any The item to search for.
---@return boolean contains Whether or not the item given is within the table.
function table.contains(tbl, item)
    for _, v in ipairs(tbl) do
        if v == item then return true end
    end
    return false
end

table.includes = table.contains -- provide alias bc i'm a js user kekw
