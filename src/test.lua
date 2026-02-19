function runTest()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local fov = 90
    local fovRad = fov / 180 * math.pi
    local f = 1 / math.tan(fovRad / 2)
    local screenWidth = dim.x
    local screenHeight = dim.y
    local aspectRatio = screenWidth / screenHeight
    local zNear = 0.1
    local zFar = 1000
    local q = zFar / (zFar - zNear)

    local absMinM = math.min(math.abs(game.get.svMultiplierAt(state.SongTime) ^ 2), 5)

    local speed = absMinM * state.DeltaTime / 300

    local projectionMatrix = {
        { f / aspectRatio, 0, 0,          0 },
        { 0,               f, 0,          0 },
        { 0,               0, q,          1 },
        { 0,               0, -zNear * q, 0 },
    }

    local inputPoints = {
        { -(math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { (math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { -(math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { (math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { -(math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { (math.sqrt(absMinM / 4) * 0.9 + 0.1), -(math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { -(math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
        { (math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), (math.sqrt(absMinM / 4) * 0.9 + 0.1), 1 },
    }

    local edgeIndices = {
        { 1, 2 }, { 1, 3 }, { 1, 5 }, { 4, 2 }, { 4, 3 }, { 4, 8 },
        { 6, 5 }, { 6, 8 }, { 6, 2 }, { 7, 5 }, { 7, 8 }, { 7, 3 },
    }

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

    for idx, point in pairs(inputPoints) do
        local inputPoint = table.map(point, function(i) return table.duplicate({ i }) end)
        inputPoint = matrix.multiply(matRotZ, inputPoint)
        inputPoint = matrix.multiply(matRotX, inputPoint)

        inputPoint[3][1] = inputPoint[3][1] + 5
        local outputPoint = matrix.multiply(projectionMatrix, inputPoint)

        outputPoint = table.vectorize4(table.map(outputPoint, function(t) return t[1] end)) / 3 * 2
        outputPoint = outputPoint * (outputPoint.w ~= 0 and outputPoint.w or 1)

        outputPoint = (outputPoint + vector.New(1, 1, 1, 0)) / 2 *
            vector.New(screenWidth, screenHeight, 1, 1)
        local output2D = vector.New(outputPoint.x, outputPoint.y)
        table.insert(outputPoints, output2D)
        if (idx <= 8) then
            ctx.AddCircleFilled(topLeft + output2D, 5,
                color.int.white)
        end
    end

    for _, pair in ipairs(edgeIndices) do
        local p1 = outputPoints[pair[1]]
        local p2 = outputPoints[pair[2]]

        ctx.AddLine(topLeft + p1, topLeft + p2, color.int.white)
    end
end
