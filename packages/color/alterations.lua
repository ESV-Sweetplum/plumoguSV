---Alters opacity of a given color.
---@param col integer
---@param additiveOpacity integer A number corresponding to the addition to the alpha channel (0-255).
---@return number
---@overload fun(col: Vector4, additiveOpacity: number): Vector4
function color.alterOpacity(col, additiveOpacity)
    if (type(col) ~= 'number') then
        return col + vector.New(0, 0, 0, additiveOpacity)
    end
    return col + math.floor(additiveOpacity) * 16777216
end
