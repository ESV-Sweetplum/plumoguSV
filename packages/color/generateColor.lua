---Generates a random color.
---@param includeAlpha boolean If false, alpha will always be 1.
---@return Vector4
function generateColor(includeAlpha)
    local r = math.random(255)
    local g = math.random(255)
    local b = math.random(255)
    local a = math.random(255)

    return vector.New(r, g, b, includeAlpha and a or 255)
end
