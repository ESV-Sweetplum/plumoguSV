local stars_xList = {}
local stars_yList = {}
local stars_vxList = {}
local stars_szList = {}

function renderReactiveStars()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local dimX = dim.x
    local dimY = dim.y

    local clamp = math.clamp

    if (dimX < 100 or clock.getTime() < 0.3) then return end

    createStar(dimX, dimY, 100)
    updateStars(dimX, dimY, state.DeltaTime)

    for i = 1, #stars_xList do
        local x = stars_xList[i]
        local y = stars_yList[i]
        local sz = stars_szList[i]
        local progress = x / dimX
        local brightness = clamp(-8 * progress * (progress - 1), -1, 1)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)

        if brightness < 0 then goto nextStar end

        -- ctx.AddCircleFilled(pos, sz * 2, color.alterOpacity(color.int.white, (255 - math.floor(brightness * 255)) - 255))
        ctx.AddCircleFilled(pos, sz * 2, color.int.whiteMask * 255 + color.int.alphaMask * 255 * brightness / 10)
        ctx.AddCircleFilled(pos, sz, color.alterOpacity(color.int.white, math.floor(brightness * 255) - 255))
        ::nextStar::
    end
end

function createStar(dimX, dimY, n)
    if (#stars_xList >= n) then return end
    stars_xList[#stars_xList + 1] = math.random() * dimX
    stars_yList[#stars_yList + 1] = math.random() * dimY
    stars_vxList[#stars_vxList + 1] = math.random() * 3 + 1
    stars_szList[#stars_szList + 1] = math.random(3) * 0.5
end

function updateStars(dimX, dimY, dt)
    local random = math.random
    local clamp = math.clamp

    local m = game.getSVMultiplierAt(state.SongTime)

    for i = 1, #stars_xList do
        local starWrapped = false

        local x = stars_xList[i]
        local y = stars_yList[i]
        local vx = stars_vxList[i]

        while (x > dimX + 10) do
            starWrapped = true
            x = x - dimX - 20
        end
        while (x < -10) do
            starWrapped = true
            x = x + dimX + 20
        end
        stars_xList[i] = x
        if starWrapped then
            stars_yList[i] = random() * dimY
            stars_vxList[i] = random() * 3 + 1
            stars_szList[i] = random(3) * 0.5
        else
            stars_xList[i] = x + vx * dt * 0.05 *
                clamp(2 * m, -50, 50)
        end
    end
end
