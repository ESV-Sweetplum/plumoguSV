require('packages.truthy')
---Converts a table (or any other primitive values) to a string.
---@param var any
---@return string
function table.stringify(var)
    if (type(var) == 'boolean') then return var and 'TRUE' or 'FALSE' end
    if (type(var) == 'string') then return '"' .. var .. '"' end
    if (type(var) == 'number') then return var end
    if (type(var) ~= 'table') then return 'UNKNOWN' end
    if (var[1] ~= nil) then
        local str = '['
        for _, v in ipairs(var) do
            str = str .. table.stringify(v) .. ','
        end
        return str:sub(1, -2) .. ']'
    end -- from below, must be a key-value table
    if (not isTruthy(table.keys(var))) then return '[]' end
    local str = '{'
    for k, v in pairs(var) do
        str = str .. k .. '=' .. table.stringify(v) .. ','
    end
    return str:sub(1, -2) .. '}'
end
