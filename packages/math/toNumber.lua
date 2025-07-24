---Alias of [tonumber](lua://tonumber) for type coercion.
---@param x string | number
---@return number
function math.toNumber(x)
    local result = tonumber(x)
    if (not result or type(result) ~= "number") then return 0 end
    return result
end
