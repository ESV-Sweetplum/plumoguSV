local xList = {}
local yList = {}
local vxList = {}
local vyList = {}
local axList = {}
local ayList = {}

function renderReactiveSingularities()
    local imgui = imgui
    local math = math
    local state = state

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local multiplier = game.getSVMultiplierAt(state.SongTime)

    local dimX = dim.x
    local dimY = dim.y

    local sqrt = math.sqrt
    local clamp = math.clamp

    -- DOES NOT USE GETVARIABLES PARADIGM DUE TO FRAME RATE INEFFICIENCY

    local pulseStatus = cache.pulseValue or 0

    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255

    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117

    local speed = clamp(math.abs(multiplier), 0, 4)
    if (dimX < 100 or imgui.GetTime() < 0.3) then return end

    createParticle(dimX, dimY, 150)
    updateParticles(dimX, dimY,
        state.DeltaTime * speed, multiplier)

    local lerp = function(w, l, h)
        return w * h + (1 - w) * l
    end

    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local vx = vxList[i]
        local vy = vyList[i]

        local s = sqrt(vx ^ 2 + vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)
        ctx.AddCircleFilled(pos, 2,
            rgbaToUint(r, g, b, 100 + pulseStatus * 155))
    end

    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295 - math.floor(pulseStatus * 120) * 16777216)
    ctx.AddCircle(dim / 2 + topLeft, 24 - pulseStatus * 8, 16777215 + math.floor(pulseStatus * 255) * 16777216)
end

function createParticle(dimX, dimY, n)
    if (#xList >= n) then return end
    xList[#xList + 1] = math.random() * dimX
    yList[#yList + 1] = math.random() * dimY
    vxList[#vxList + 1] = 0
    vyList[#vyList + 1] = 0
    axList[#axList + 1] = 0
    ayList[#ayList + 1] = 0
end

function updateParticles(dimX, dimY, dt, multiplier)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local spinDir = math.sign(multiplier)

    local movementSpeed = 0.1
    local bounceCoefficient = 0.8

    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local vx = vxList[i]
        local vy = vyList[i]
        local ax = axList[i]
        local ay = ayList[i]

        local sgPosx = bit32.rshift(dimX, 1)
        local sgPosy = bit32.rshift(dimY, 1)
        local xDist = sgPosx - x
        local yDist = sgPosy - y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        if (dist < 10) then dist = 10 end

        local gravityFactor = bit32.rshift(dist ^ 3, 9)

        local gx = xDist / gravityFactor
        local gy = yDist / gravityFactor

        local spinFactor = 10 * spinDir / sqrt(dist)

        axList[i] = gx + gy * spinFactor
        ayList[i] = gy - gx * spinFactor

        local movementDist = dt * movementSpeed

        vxList[i] = vx + ax * movementDist
        vyList[i] = vy + ay * movementDist
        xList[i] = x + vx * movementDist
        yList[i] = y + vy * movementDist

        if (x < 0 or x > dimX) then
            vxList[i] = -vxList[i] * bounceCoefficient
            xList[i] = clamp(xList[i], 1, dimX - 1)
        end
        if (y < 0 or y > dimY) then
            vyList[i] = -vyList[i] * bounceCoefficient
            yList[i] = clamp(yList[i], 1, dimY - 1)
        end

        local dragFactor = 1 - dt / 500

        vxList[i] = clamp(vxList[i] * dragFactor, -5, 5)
        vyList[i] = clamp(vyList[i] * dragFactor, -5, 5)
    end
end
