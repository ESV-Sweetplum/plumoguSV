---Splits a string into a table via the given separator.
---@param str string
---@param sep string
---@return string[]
function string.split(str, sep)
    local tbl = {}
    for s in str:gmatch('([^' .. sep .. ']+)') do
        table.insert(tbl, s)
    end

    return tbl
end
