---Alters opacity of a given color.
---@param col integer
---@param additiveOpacity integer
---@return number
---@overload fun(col: Vector4, additiveOpacity: number): Vector4
function color.alterOpacity(col, additiveOpacity)
    if (type(col) ~= "number") then
        return col + vector.New(0, 0, 0, additiveOpacity)
    end
    return col + math.floor(additiveOpacity) * 16777216
end
