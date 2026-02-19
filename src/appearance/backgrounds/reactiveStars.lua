local stars_xList = {}
local stars_yList = {}
local stars_vxList = {}
local stars_szList = {}
local stars_listSize = 0

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

    for i = 1, stars_listSize do
        local x = stars_xList[i]
        local y = stars_yList[i]
        local sz = stars_szList[i]
        local progress = x / dimX
        local brightness = clamp(-8 * progress * (progress - 1), -1, 1)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)

        if brightness < 0 then goto nextStar end

        -- ctx.AddCircleFilled(pos, sz * 2, color.alterOpacity(color.int.white, (255 - math.floor(brightness * 255)) - 255))
        ctx.AddCircleFilled(pos, sz * 2, color.int.white + color.int.alphaMask * 255 * (brightness / 10 - 1))
        ctx.AddCircleFilled(pos, sz, color.int.white + color.int.alphaMask * 255 * (brightness - 1))
        ::nextStar::
    end
end

function createStar(dimX, dimY, n)
    if (stars_listSize >= n) then return end
    stars_xList[stars_listSize + 1] = math.random() * dimX
    stars_yList[stars_listSize + 1] = math.random() * dimY
    stars_vxList[stars_listSize + 1] = math.random() * 3 + 1
    stars_szList[stars_listSize + 1] = math.random(3) * 0.5
    stars_listSize = stars_listSize + 1
end

function updateStars(dimX, dimY, dt)
    local random = math.random
    local clamp = math.clamp

    local m = game.get.svMultiplierAt(state.SongTime)

    for i = 1, stars_listSize do
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
