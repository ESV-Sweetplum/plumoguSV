---@class GraphPoint
---@field pos Vector2 A Vector2 of two elements between 0-1.
---@field col integer Unsigned integer of the color.
---@field size number Radius of the point.

---Creates a graph and returns the context to run functions on.
---@param label string The hidden label of the graph.
---@param size Vector2 The size of the graph.
---@param points GraphPoint[] A list of points that can be dragged around.
---@param preferForeground? boolean Set this to true if you want to use `GetForegroundDrawList` instead of `GetWindowDrawList`.
---@param gridSize? integer To what degree you'd like the points to snap to.
---@param yScale? Vector2 If included, will create labels corresponding to this scale.
---@return ImDrawListPtr
---@return boolean changed
function renderGraph(label, size, points, preferForeground, gridSize, yScale)
    local gray = color.int.white * 100 / 255
    local tableLabel = table.concat({ "graph_points_", label })
    local initDragList = {}
    local initPointList = {}
    for i = 1, #points do
        table.insert(initDragList, false)
        table.insert(initPointList, points[i].pos)
    end
    local dragList = state.GetValue(tableLabel, initDragList)

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    if (preferForeground) then ctx = imgui.GetForegroundDrawList() end

    for i, point in ipairs(points) do
        imgui.SetCursorPos(point.pos - vctr2(point.size))
        imgui.InvisibleButton(tableLabel .. i, vctr2(point.size * 2))

        if (imgui.IsMouseDown("Left") and imgui.IsItemActive()) then
            dragList[i] = true
        end
        if (imgui.IsMouseDragging("Left") and dragList[i]) then
            point.pos = point.pos + kbm.mouseDelta()
        end

        local col = point.col
        local alphaDifference = 150 * 16 ^ 6
        if (not dragList[i]) then col = col - alphaDifference end

        ctx.AddCircleFilled(topLeft + point.pos, point.size, col)
    end

    gridSize = gridSize or 1

    if (not imgui.IsMouseDown("Left")) then
        for i = 1, #points do
            dragList[i] = false
            local roundedX = math.round(points[i].pos.x / gridSize) * gridSize
            local roundedY = math.round(points[i].pos.y / gridSize) * gridSize

            points[i].pos = vector.New(roundedX, roundedY)
        end
    end

    if (gridSize ~= 1) then
        for i = 0, size.x, gridSize do
            local col = gray
            if (not truthy(i % 4)) then
                col = color.rgbaToUint(100, 100, 100, 255)
            end
            ctx.AddLine(vector.New(topLeft.x + i, topLeft.y), vector.New(topLeft.x + i, topLeft.y + dim.y), col, 1)
        end
        for i = 0, size.y, gridSize do
            local col = gray
            if (not truthy(i % 4)) then
                col = color.rgbaToUint(100, 100, 100, 255)
            end
            if (yScale and not truthy(i % 4)) then
                local number = (yScale.y - yScale.x) * (size.y - i) / size.y + yScale.x
                local textSize = imgui.CalcTextSize(tostring(number))
                ctx.AddText(
                    vector.New(topLeft.x + 6, math.clamp(topLeft.y + i - 7, topLeft.y + 5, topLeft.y + dim.y - 16)),
                    color.int.white,
                    tostring(number))
                ctx.AddLine(vector.New(topLeft.x + textSize.x + 10, topLeft.y + i),
                    vector.New(topLeft.x + dim.x, topLeft.y + i), col,
                    1)
            else
                ctx.AddLine(vector.New(topLeft.x, topLeft.y + i), vector.New(topLeft.x + dim.x, topLeft.y + i), col,
                    1)
            end
        end
    end

    local pointChanged = false
    for i = 1, #points do
        if (points[i].pos ~= initPointList[i]) then
            pointChanged = true
            break
        end
    end

    state.SetValue(tableLabel, dragList)

    return ctx, pointChanged
end
