---@class GraphPoint
---@field pos Vector2 A Vector2 of two elements between 0-1.
---@field col integer Unsigned integer of the color.
---@field size number Radius of the point.

---Creates a graph and returns the context to run functions on.
---@param label string The hidden label of the graph.
---@param size Vector2 The size of the graph.
---@param points GraphPoint[] A list of points that can be dragged around.
---@param preferForeground? boolean Set this to true if you want to use `GetForegroundDrawList` instead of `GetWindowDrawList`.
---@return ImDrawListPtr
function renderGraph(label, size, points, preferForeground)
    local tableLabel = table.concat({ "graph_points_", label })
    local initDragList = {}
    for i = 1, #points do
        table.insert(initDragList, false)
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

    if (not imgui.IsMouseDown("Left")) then
        for i = 1, #points do
            dragList[i] = false
        end
    end

    state.SetValue(tableLabel, dragList)

    return ctx
end
