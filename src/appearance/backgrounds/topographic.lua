function renderTopographicMap()
    --- {top-right, right-bottom, bottom-left, left-top, top-bottom, left-right}
    local nodeToEdge = {
        { false, false, false, false, false, false },
        { false, false, false, true,  false, false },
        { true,  false, false, false, false, false },
        { false, false, false, false, false, true },
        { false, false, true,  false, false, false },
        { false, false, false, false, true,  false },
        { true,  false, true,  false, false, false },
        { false, true,  false, false, false, false },
        { false, true,  false, false, false, false },
        { false, true,  false, true,  false, false },
        { false, false, false, false, true,  false },
        { false, false, true,  false, false, false },
        { false, false, false, false, false, true },
        { true,  false, false, false, false, false },
        { false, false, false, true,  false, false },
        { false, false, false, false, false, false },
    }

    local CELL_SIZE = 10
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local xCellCount = math.ceil(dim.x / CELL_SIZE)
    local yCellCount = math.ceil(dim.y / CELL_SIZE)

    local xNodeCount = xCellCount + 1
    local yNodeCount = yCellCount + 1

    local map = {}

    for j = 1, yNodeCount do
        local row = {}
        for i = 1, xNodeCount do
            local noise = perlin.noise(i / xNodeCount * 5, j / yNodeCount * 5, state.UnixTime / 5000)
            table.insert(row, noise)
        end
        table.insert(map, row)
    end

    local lowestX = 1e69;
    local lowestY = 1e69;

    local lineColor = color.alterOpacity(color.int.white, -120)
    local edgeColor = color.int.white
    local edgeThickness = 2

    if (truthy(xCellCount % 2)) then
        local centerX = dim.x / 2
        local xPos = centerX - CELL_SIZE / 2
        while (xPos > 0) do
            -- ctx.AddLine(topLeft + vector.New(xPos, 0), topLeft + vector.New(xPos, dim.y), lineColor, 1)
            xPos = xPos - CELL_SIZE
        end
        lowestX = xPos
    else
        local centerX = dim.x / 2
        local xPos = centerX
        while (xPos > 0) do
            -- ctx.AddLine(topLeft + vector.New(xPos, 0), topLeft + vector.New(xPos, dim.y), lineColor, 1)
            xPos = xPos - CELL_SIZE
        end
        lowestX = xPos
    end

    if (truthy(yCellCount % 2)) then
        local centerY = dim.y / 2
        local yPos = centerY - CELL_SIZE / 2
        while (yPos > 0) do
            -- ctx.AddLine(topLeft + vector.New(0, yPos), topLeft + vector.New(dim.x, yPos), lineColor, 1)
            yPos = yPos - CELL_SIZE
        end
        lowestY = yPos
    else
        local centerY = dim.y / 2
        local yPos = centerY
        while (yPos > 0) do
            -- ctx.AddLine(topLeft + vector.New(0, yPos), topLeft + vector.New(dim.x, yPos), lineColor, 1)
            yPos = yPos - CELL_SIZE
        end
        lowestY = yPos
    end

    local graphTopLeft = topLeft + vector.New(lowestX, lowestY)

    for y = 0, yNodeCount - 1 do
        for x = 0, xNodeCount - 1 do
            if (map[y + 1][x + 1] < 0) then
                ctx.AddCircleFilled(graphTopLeft + CELL_SIZE * vector.New(x, y), 2,
                    color.int.redMask * map[y + 1][x + 1] * -255 + color.int.alphaMask * 255)
            else
                ctx.AddCircleFilled(graphTopLeft + CELL_SIZE * vector.New(x, y), 2,
                    color.vrgbaToUint(color.vctr.white * map[y + 1][x + 1] + color.vctr.black * (1 - map[y + 1][x + 1])))
            end
        end
    end

    for y = 1, yCellCount do
        for x = 1, xCellCount do
            local tlState = truthy(map[y][x]) and 1 or 0
            local trState = truthy(map[y][x + 1]) and 1 or 0
            local blState = truthy(map[y + 1][x]) and 1 or 0
            local brState = truthy(map[y + 1][x + 1]) and 1 or 0

            local cellState = tlState + trState * 2 + blState * 4 + brState * 8
            local topZeroLocation = -map[y][x] / (map[y][x + 1] - map[y][x] + math.epsilon)
            local bottomZeroLocation = -map[y + 1][x] / (map[y + 1][x + 1] - map[y + 1][x] + math.epsilon)
            local leftZeroLocation = -map[y][x] / (map[y + 1][x] - map[y][x] + math.epsilon)
            local rightZeroLocation = -map[y][x + 1] / (map[y + 1][x + 1] - map[y][x + 1] + math.epsilon)

            local topPoint = graphTopLeft +
                CELL_SIZE * vector.New(x - 1 + topZeroLocation, y - 1)
            local bottomPoint = graphTopLeft +
                CELL_SIZE * vector.New(x - 1 + bottomZeroLocation, y)
            local leftPoint = graphTopLeft + CELL_SIZE * vector.New(x - 1, y - 1 + leftZeroLocation)
            local rightPoint = graphTopLeft + CELL_SIZE * vector.New(x, y - 1 + rightZeroLocation)

            local edgeList = nodeToEdge[cellState + 1]
            if (edgeList[1]) then ctx.AddLine(topPoint, rightPoint, edgeColor, edgeThickness) end
            if (edgeList[2]) then ctx.AddLine(rightPoint, bottomPoint, edgeColor, edgeThickness) end
            if (edgeList[3]) then ctx.AddLine(bottomPoint, leftPoint, edgeColor, edgeThickness) end
            if (edgeList[4]) then ctx.AddLine(leftPoint, topPoint, edgeColor, edgeThickness) end
            if (edgeList[5]) then ctx.AddLine(topPoint, bottomPoint, edgeColor, edgeThickness) end
            if (edgeList[6]) then ctx.AddLine(leftPoint, rightPoint, edgeColor, edgeThickness) end
        end
    end
end

--[[
    Perlin Noise Implementation from https://gist.github.com/kymckay/25758d37f8e3872e1636d90ad41fe2ed

    Implemented as described here:
    http://flafla2.github.io/2014/08/09/perlinnoise.html
]] --

perlin = {}
perlin.p = {}

-- Hash lookup table as defined by Ken Perlin
-- This is a randomly arranged array of all numbers from 0-255 inclusive
local permutation = { 151, 160, 137, 91, 90, 15,
    131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
    190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
    88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
    77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
    102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
    135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
    5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
    223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
    129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
    251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
    49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
    138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180,
}

-- p is used to hash unit cube coordinates to [0, 255]
for i = 0, 255 do
    -- Convert to 0 based index table
    perlin.p[i] = permutation[i + 1]
    -- Repeat the array to avoid buffer overflow in hash function
    perlin.p[i + 256] = permutation[i + 1]
end

-- Return range: [-1, 1]
function perlin.noise(x, y, z)
    y        = y or 0
    z        = z or 0

    -- Calculate the "unit cube" that the point asked will be located in
    local xi = bit32.band(math.floor(x), 255)
    local yi = bit32.band(math.floor(y), 255)
    local zi = bit32.band(math.floor(z), 255)

    -- Next we calculate the location (from 0 to 1) in that cube
    x        = x - math.floor(x)
    y        = y - math.floor(y)
    z        = z - math.floor(z)

    -- We also fade the location to smooth the result
    local u  = perlin.fade(x)
    local v  = perlin.fade(y)
    local w  = perlin.fade(z)

    -- Hash all 8 unit cube coordinates surrounding input coordinate
    local p  = perlin.p
    local A, AA, AB, AAA, ABA, AAB, ABB, B, BA, BB, BAA, BBA, BAB, BBB
    A        = p[xi] + yi
    AA       = p[A] + zi
    AB       = p[A + 1] + zi
    AAA      = p[AA]
    ABA      = p[AB]
    AAB      = p[AA + 1]
    ABB      = p[AB + 1]

    B        = p[xi + 1] + yi
    BA       = p[B] + zi
    BB       = p[B + 1] + zi
    BAA      = p[BA]
    BBA      = p[BB]
    BAB      = p[BA + 1]
    BBB      = p[BB + 1]

    -- Take the weighted average between all 8 unit cube coordinates
    return perlin.lerp(w,
        perlin.lerp(v,
            perlin.lerp(u,
                perlin.grad(AAA, x, y, z),
                perlin.grad(BAA, x - 1, y, z)
            ),
            perlin.lerp(u,
                perlin.grad(ABA, x, y - 1, z),
                perlin.grad(BBA, x - 1, y - 1, z)
            )
        ),
        perlin.lerp(v,
            perlin.lerp(u,
                perlin.grad(AAB, x, y, z - 1), perlin.grad(BAB, x - 1, y, z - 1)
            ),
            perlin.lerp(u,
                perlin.grad(ABB, x, y - 1, z - 1), perlin.grad(BBB, x - 1, y - 1, z - 1)
            )
        )
    )
end

-- Gradient function finds dot product between pseudorandom gradient vector
-- and the vector from input coordinate to a unit cube vertex
perlin.dot_product = {
    [0x0] = |x,y,z| x + y,
    [0x1] = |x,y,z| -x + y,
    [0x2] = |x,y,z| x - y,
    [0x3] = |x,y,z| -x - y,
    [0x4] = |x,y,z| x + z,
    [0x5] = |x,y,z| -x + z,
    [0x6] = |x,y,z| x - z,
    [0x7] = |x,y,z| -x - z,
    [0x8] = |x,y,z| y + z,
    [0x9] = |x,y,z| -y + z,
    [0xA] = |x,y,z| y - z,
    [0xB] = |x,y,z| -y - z,
    [0xC] = |x,y,z| y + x,
    [0xD] = |x,y,z| -y + z,
    [0xE] = |x,y,z| y - x,
    [0xF] = |x,y,z| -y - z,
}
function perlin.grad(hash, x, y, z)
    return perlin.dot_product[bit32.band(hash, 0xF)](x, y, z)
end

-- Fade function is used to smooth final output
function perlin.fade(t)
    return t * t * t * (t * (t * 6 - 15) + 10)
end

function perlin.lerp(t, a, b)
    return a + t * (b - a)
end
