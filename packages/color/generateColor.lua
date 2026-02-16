---Generates a random color.
---@param includeAlpha boolean If false, alpha will always be 1.
---@return Vector4
function generateRGBColor(includeAlpha)
    local r = math.random()
    local g = math.random()
    local b = math.random()
    local a = math.random()

    return vector.New(r, g, b, includeAlpha and a or 1)
end
