function runTest()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local fov = 90
    local zoom = (1 / (1 + math.exp(-1 * (state.SongTime - 52619) / 30)))
    local fovRad = fov / 180 * math.pi
    local f = 1 / math.tan(fovRad / 2)
    local screenWidth = dim.x
    local screenHeight = dim.y
    local aspectRatio = screenWidth / screenHeight
    local zNear = 0.1
    local zFar = 1000
    local q = zFar / (zFar - zNear)

    local absMinM = math.min(math.abs(game.get.svMultiplierAt(state.SongTime) ^ 2), 5)

    if (state.SongTime - state.DeltaTime < 52619 and state.SongTime > 52619) then
        print('e!', 'No one will believe you.')
    end

    local speed = absMinM * state.DeltaTime / 300

    local cameraPos = { 0, 4, -7 }

    local projectionMatrix = {
        { f / aspectRatio, 0, 0,          0 },
        { 0,               f, 0,          0 },
        { 0,               0, q,          1 },
        { 0,               0, -zNear * q, 0 },
    }

    local inputPoints = {
        { 1,  -1, -1, 1 },
        { 3,  -1, -1, 1 },
        { 1,  1,  -1, 1 },
        { 3,  1,  -1, 1 },
        { 1,  -1, 1,  1 },
        { 3,  -1, 1,  1 },
        { 1,  1,  1,  1 },
        { 3,  1,  1,  1 },
        { -1, -1, -1, 1 },
        { -3, -1, -1, 1 },
        { -1, 1,  -1, 1 },
        { -3, 1,  -1, 1 },
        { -1, -1, 1,  1 },
        { -3, -1, 1,  1 },
        { -1, 1,  1,  1 },
        { -3, 1,  1,  1 },
        { -1, 1,  -1, 1 },
        { 1,  1,  -1, 1 },
        { -1, 10, -1, 1 },
        { 1,  10, -1, 1 },
        { -1, 1,  1,  1 },
        { 1,  1,  1,  1 },
        { -1, 10, 1,  1 },
        { 1,  10, 1,  1 },
    }

    local edgeIndices = {
        { 1, 2 }, { 1, 3 }, { 1, 5 }, { 4, 2 }, { 4, 3 }, { 4, 8 },
        { 6, 5 }, { 6, 8 }, { 6, 2 }, { 7, 5 }, { 7, 8 }, { 7, 3 },
        { 9,  10 }, { 9, 11 }, { 9, 13 }, { 12, 10 }, { 12, 11 }, { 12, 16 },
        { 14, 13 }, { 14, 16 }, { 14, 10 }, { 15, 13 }, { 15, 16 }, { 15, 11 },
        { 17, 18 }, { 17, 19 }, { 17, 21 }, { 20, 18 }, { 20, 19 }, { 20, 24 },
        { 22, 21 }, { 22, 24 }, { 22, 18 }, { 23, 21 }, { 23, 24 }, { 23, 19 },
    }

    local surfaceIndices = {
        { 1,  2,  3,  4,  color.int.red },
        { 5,  6,  7,  8,  color.int.red },
        { 1,  3,  5,  7,  color.int.red },
        { 2,  4,  6,  8,  color.int.red },
        { 1,  2,  5,  6,  color.int.red },
        { 3,  4,  7,  8,  color.int.red },
        { 9,  10, 11, 12, color.int.blue },
        { 13, 14, 15, 16, color.int.blue },
        { 9,  11, 13, 15, color.int.blue },
        { 10, 12, 14, 16, color.int.blue },
        { 9,  10, 13, 14, color.int.blue },
        { 11, 12, 15, 16, color.int.blue },
        { 17, 18, 19, 20, color.int.green },
        { 21, 22, 23, 24, color.int.green },
        { 17, 19, 21, 23, color.int.green },
        { 18, 20, 22, 24, color.int.green },
        { 17, 18, 21, 22, color.int.green },
        { 19, 20, 23, 24, color.int.green },
    }

    local cameraPoints = {}
    local outputPoints = {}

    if (not cache.theta) then cache.theta = 0 end
    cache.theta = cache.theta + speed

    local theta = cache.theta
    local matRotZ = {
        { math.cos(theta),  math.sin(theta), 0, 0 },
        { -math.sin(theta), math.cos(theta), 0, 0 },
        { 0,                0,               1, 0 },
        { 0,                0,               0, 1 },
    }

    local matRotX = {
        { 1, 0,                               0,                              0 },
        { 0, math.cos(theta / math.sqrt(2)),  math.sin(theta / math.sqrt(2)), 0 },
        { 0, -math.sin(theta / math.sqrt(2)), math.cos(theta / math.sqrt(2)), 0 },
        { 0, 0,                               0,                              1 },
    }

    local matRotY = {
        { math.cos(theta / math.sqrt(2)),  0, math.sin(theta / math.sqrt(2)), 0 },
        { 0,                               1, 0,                              0 },
        { -math.sin(theta / math.sqrt(2)), 0, math.cos(theta / math.sqrt(2)), 0 },
        { 0,                               0, 0,                              1 },
    }


    for idx, point in pairs(inputPoints) do
        local inputPoint = table.map(point, function(i) return table.duplicate({ i }) end)
        -- inputPoint = matrix.multiply(matRotX, inputPoint)
        inputPoint = matrix.multiply(matRotY, inputPoint)
        -- inputPoint = matrix.multiply(matRotZ, inputPoint)

        inputPoint[1][1] = inputPoint[1][1] - cameraPos[1]
        inputPoint[2][1] = inputPoint[2][1] - cameraPos[2]
        inputPoint[3][1] = inputPoint[3][1] - cameraPos[3]
        local outputPoint = matrix.multiply(projectionMatrix, inputPoint)

        outputPoint = table.map(outputPoint, function(t) return t[1] end)
        table.insert(outputPoints, outputPoint)
        outputPoint = table.vectorize4(outputPoint)
        outputPoint = outputPoint / (outputPoint.w ~= 0 and outputPoint.w or 1) / 15 * zoom

        outputPoint = (outputPoint + vctr4(1)) / 2 *
            vector.New(screenWidth, screenHeight, 1, 1)
        local output2D = vector.New(outputPoint.x, outputPoint.y)
        table.insert(cameraPoints, output2D)
        -- ctx.AddCircleFilled(topLeft + output2D, 5,
        --     color.int.white)
    end

    local triangleBuffer = {}

    for _, quad in ipairs(surfaceIndices) do
        local p1 = topLeft + cameraPoints[quad[1]]
        local p2 = topLeft + cameraPoints[quad[2]]
        local p3 = topLeft + cameraPoints[quad[3]]
        local p4 = topLeft + cameraPoints[quad[4]]


        local distFromP1ToCamera = calculateDistance(outputPoints[quad[1]], cameraPos)
        local distFromP2ToCamera = calculateDistance(outputPoints[quad[2]], cameraPos)
        local distFromP3ToCamera = calculateDistance(outputPoints[quad[3]], cameraPos)
        local distFromP4ToCamera = calculateDistance(outputPoints[quad[4]], cameraPos)

        local closestVertexDistance1 = math.min(distFromP1ToCamera, distFromP2ToCamera, distFromP3ToCamera)
        local closestVertexDistance2 = math.min(distFromP4ToCamera, distFromP2ToCamera, distFromP3ToCamera)

        local col = quad[5]

        table.insert(triangleBuffer, { p1, p2, p3, closestVertexDistance1, col })
        table.insert(triangleBuffer, { p4, p2, p3, closestVertexDistance2, col })
    end

    local sortedBuffer = sort(triangleBuffer, function(a, b)
        return a[4] > b[4]
    end)

    for _, tri in ipairs(sortedBuffer) do
        ctx.AddTriangleFilled(tri[1], tri[2], tri[3], tri[5])
    end

    for _, pair in ipairs(edgeIndices) do
        local p1 = topLeft + cameraPoints[pair[1]]
        local p2 = topLeft + cameraPoints[pair[2]]

        ctx.AddLine(p1, p2, color.int.white, 2)
    end
end

function calculateDistance(point1, point2)
    local xDist = point1[1] - point2[1]
    local yDist = point1[2] - point2[2]
    local zDist = point1[3] - point2[3]

    return math.sqrt(xDist * xDist + yDist * yDist + zDist * zDist)
end
