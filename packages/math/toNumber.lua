---Alias of [tonumber](lua://tonumber) for type coercion. Converts boolean values into their respective binary digits.
---@param x? string | number | boolean
---@return number
function math.toNumber(x)
    if (not x) then return 0 end
    if x == true then return 1 end
    local result = tonumber(x)
    if (not result or type(result) ~= "number") then return 0 end
    return result
end

tn = math.toNumber
