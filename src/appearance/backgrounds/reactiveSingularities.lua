local singularity_xList = {}
local singularity_yList = {}
local singularity_vxList = {}
local singularity_vyList = {}
local singularity_axList = {}
local singularity_ayList = {}

function renderReactiveSingularities()
    local imgui = imgui
    local math = math
    local state = state

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local multiplier = game.get.svMultiplierAt(state.SongTime)

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
    if (dimX < 100 or clock.getTime() < 0.3) then return end

    createParticle(dimX, dimY, 150)
    updateParticles(dimX, dimY,
        state.DeltaTime * speed, multiplier)

    local lerp = function(w, l, h)
        return w * h + (1 - w) * l
    end

    for i = 1, #singularity_xList do
        local x = singularity_xList[i]
        local y = singularity_yList[i]
        local vx = singularity_vxList[i]
        local vy = singularity_vyList[i]

        local s = sqrt(vx ^ 2 + vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)
        ctx.AddCircleFilled(pos, 2,
            color.rgbaToUint(r, g, b, 100 + pulseStatus * 155))
    end

    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295 - math.floor(pulseStatus * 120) * 16777216)
    ctx.AddCircle(dim / 2 + topLeft, 24 - pulseStatus * 8, 16777215 + math.floor(pulseStatus * 255) * 16777216)
end

function createParticle(dimX, dimY, n)
    if (#singularity_xList >= n) then return end
    singularity_xList[#singularity_xList + 1] = math.random() * dimX
    singularity_yList[#singularity_yList + 1] = math.random() * dimY
    singularity_vxList[#singularity_vxList + 1] = 0
    singularity_vyList[#singularity_vyList + 1] = 0
    singularity_axList[#singularity_axList + 1] = 0
    singularity_ayList[#singularity_ayList + 1] = 0
end

function updateParticles(dimX, dimY, dt, multiplier)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local spinDir = math.sign(multiplier)

    local movementSpeed = 0.1
    local bounceCoefficient = 0.8

    for i = 1, #singularity_xList do
        local x = singularity_xList[i]
        local y = singularity_yList[i]
        local vx = singularity_vxList[i]
        local vy = singularity_vyList[i]
        local ax = singularity_axList[i]
        local ay = singularity_ayList[i]

        local sgPosx = bit32.rshift(dimX, 1)
        local sgPosy = bit32.rshift(dimY, 1)
        local xDist = sgPosx - x
        local yDist = sgPosy - y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        if dist < 10 then dist = 10 end

        local gravityFactor = bit32.rshift(dist ^ 3, 9)

        local gx = xDist / gravityFactor
        local gy = yDist / gravityFactor

        local spinFactor = 10 * spinDir / sqrt(dist)

        singularity_axList[i] = gx + gy * spinFactor
        singularity_ayList[i] = gy - gx * spinFactor

        local movementDist = dt * movementSpeed

        singularity_vxList[i] = vx + ax * movementDist
        singularity_vyList[i] = vy + ay * movementDist
        singularity_xList[i] = x + vx * movementDist
        singularity_yList[i] = y + vy * movementDist

        if (x < 0 or x > dimX) then
            singularity_vxList[i] = -singularity_vxList[i] * bounceCoefficient
            singularity_xList[i] = clamp(singularity_xList[i], 1, dimX - 1)
        end
        if (y < 0 or y > dimY) then
            singularity_vyList[i] = -singularity_vyList[i] * bounceCoefficient
            singularity_yList[i] = clamp(singularity_yList[i], 1, dimY - 1)
        end

        local dragFactor = 1 - dt / 500

        singularity_vxList[i] = clamp(singularity_vxList[i] * dragFactor, -5, 5)
        singularity_vyList[i] = clamp(singularity_vyList[i] * dragFactor, -5, 5)
    end
end
