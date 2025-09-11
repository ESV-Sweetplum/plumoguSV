---Returns `true` if the input (which should be a number) is not a number.
---@param v number
---@return boolean
function isNaN(v)
    return type(v) == "number" and v ~= v
end
