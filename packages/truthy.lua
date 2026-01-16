---Returns `true` if given a string called "true", given a number greater than 0, given a table with an element, or is given `true`. Otherwise, returns `false`.
---@param param any The parameter to truthify.
---@param assumeTrue? boolean If the item is nil, will return true if this is true.
---@return boolean truthy The truthy value of the parameter.
function isTruthy(param, assumeTrue)
    local t = type(param)
    if t == "string" then
        return param:lower() == "true"
    end
    if t == "number" then
        return param > 0
    end
    if t == "table" or t == "userdata" then
        return #param > 0
    end
    if t == "boolean" then
        return param
    end
    return assumeTrue or false
end
