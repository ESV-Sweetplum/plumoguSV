function renderReactiveStars()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local dimX = dim.x
    local dimY = dim.y

    local clamp = math.clamp

    local xList = state.GetValue("stars_xList", {})
    local yList = state.GetValue("stars_yList", {})
    local vxList = state.GetValue("stars_vxList", {})
    local szList = state.GetValue("stars_szList", {})

    if (dimX < 100 or imgui.GetTime() < 0.3) then return end

    createStar(xList, yList, vxList, szList, dimX, dimY, 100)
    updateStars(xList, yList, vxList, szList, dimX, dimY, state.DeltaTime)

    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local sz = szList[i]
        local progress = x / dimX
        local brightness = clamp(-8 * progress * (progress - 1), 0, 1)
        local pos = { x + topLeft.x, y + topLeft.y }

        ctx.AddCircleFilled(pos, sz, rgbaToUint(255, 255, 255, brightness * 255))
    end

    state.SetValue("stars_xList", xList)
    state.SetValue("stars_yList", yList)
    state.SetValue("stars_vxList", vxList)
    state.SetValue("stars_szList", szList)
end

function createStar(x, y, vx, sz, dimX, dimY, n)
    if (#x >= n) then return end
    x[#x + 1] = math.random() * dimX
    y[#y + 1] = math.random() * dimY
    vx[#vx + 1] = math.random() * 3 + 1
    sz[#sz + 1] = math.random(3) * 0.5
end

function updateStars(xl, yl, vxl, szl, dimX, dimY, dt)
    local random = math.random
    local clamp = math.clamp

    local m = game.getSVMultiplierAt(state.SongTime)

    for i = 1, #xl do
        local starWrapped = false

        local x = xl[i]
        local y = yl[i]
        local vx = vxl[i]

        while (x > dimX + 10) do
            starWrapped = true
            x = x - dimX - 20
        end
        while (x < -10) do
            starWrapped = true
            x = x + dimX + 20
        end
        xl[i] = x
        if (starWrapped) then
            yl[i] = random() * dimY
            vxl[i] = random() * 3 + 1
            szl[i] = random(3) * 0.5
        else
            xl[i] = x + vx * dt * 0.05 *
                clamp(2 * m, -50, 50)
        end
    end
end
