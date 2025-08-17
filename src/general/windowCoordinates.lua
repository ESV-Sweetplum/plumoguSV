-- Returns coordinates relative to the plugin window [Table]
-- Parameters
--    x : x coordinate relative to the plugin window [Int]
--    y : y coordinate relative to the plugin window [Int]
function coordsRelativeToWindow(x, y)
    return vector.New(x, y) + imgui.GetWindowPos()
end

-- Returns a point relative to a given point [Table]
-- Parameters
--    point   : (x, y) coordinates [Table]
--    xChange : change in x coordinate [Int]
--    yChange : change in y coordinate [Int]
function relativePoint(point, xChange, yChange)
    return point + vector.New(xChange, yChange)
end
