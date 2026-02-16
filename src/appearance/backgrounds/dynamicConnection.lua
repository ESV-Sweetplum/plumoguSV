local nodes_xList = {}
local nodes_yList = {}
local nodes_vxList = {}
local nodes_vyList = {}
local nodes_lifetimes = {}
local nodes_distsToNearestEdge = {}

function renderDynamicConnection()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local dt = state.DeltaTime * 0.05

    if (#nodes_xList < 18) then
        table.insert(nodes_xList, topLeft.x + math.random() * dim.x)
        table.insert(nodes_yList, topLeft.y + math.random() * dim.y)
        table.insert(nodes_vxList, math.random() * 2 - 1)
        table.insert(nodes_vyList, math.random() * 2 - 1)
        table.insert(nodes_lifetimes, 0)
        table.insert(nodes_distsToNearestEdge, 67000)
    end

    local mainCol = imgui.GetColorU32('TabSelected', 6742069)
    local maxDist = (math.min(dim.x * 0.6, dim.y * 0.6)) ^ 2
    local circleBuffer = 10

    for i = 1, #nodes_xList do
        local x = nodes_xList[i]
        local y = nodes_yList[i]
        local opacity = math.clamp(math.floor(nodes_lifetimes[i]), 0, 255)

        nodes_distsToNearestEdge[i] =
            math.min(topLeft.x + dim.x - x, x - topLeft.x, topLeft.y + dim.y - y,
                y - topLeft.y)

        local dist = nodes_distsToNearestEdge[i]

        if (dist < -circleBuffer) then
            nodes_xList[i] = topLeft.x + math.random() * dim.x
            nodes_yList[i] = topLeft.y + math.random() * dim.y
            nodes_vxList[i] = math.random() * 2 - 1
            nodes_vyList[i] = math.random() * 2 - 1
            nodes_lifetimes[i] = 0
            goto nextNode
        end

        nodes_xList[i] = x + nodes_vxList[i] * dt
        nodes_yList[i] = y + nodes_vyList[i] * dt
        nodes_lifetimes[i] = nodes_lifetimes[i] + dt * 6

        ctx.AddCircleFilled(vector.New(x, y), 3, mainCol - color.int.alphaMask * (255 - opacity))
        ::nextNode::
    end

    for i = 1, #nodes_xList do
        for j = 1, #nodes_xList do
            local x1 = nodes_xList[i]
            local y1 = nodes_yList[i]
            local x2 = nodes_xList[j]
            local y2 = nodes_yList[j]

            local dist = (y2 - y1) ^ 2 + (x2 - x1) ^ 2

            if (dist > maxDist) then goto nextNode end

            ctx.AddLine(vector.New(x1, y1), vector.New(x2, y2),
                mainCol -
                color.int.alphaMask *
                (127 + math.max(
                    math.floor((128 * (dist / maxDist) ^ 0.15)),
                    128 - math.clamp(math.floor(math.min(nodes_lifetimes[i], nodes_lifetimes[j])
                    ), 0, 128),
                    128 - math.floor(128 * math.clamp(5 * (math.min(nodes_distsToNearestEdge[i], nodes_distsToNearestEdge[j]) + circleBuffer) / math.max(dim.x, dim.y), 0, 1))
                )), 2)
            ::nextNode::
        end
    end
end
