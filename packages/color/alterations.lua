function color.alterOpacity(col, additiveOpacity)
    if (type(col) ~= "number") then
        return col + vector.New(0, 0, 0, additiveOpacity)
    end
    return col + additiveOpacity * 16 ^ 6
end
