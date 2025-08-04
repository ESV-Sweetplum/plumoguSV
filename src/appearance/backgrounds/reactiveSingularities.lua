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

    local xList = state.GetValue("singularity_xList", {})
    local yList = state.GetValue("singularity_yList", {})
    local vxList = state.GetValue("singularity_vxList", {})
    local vyList = state.GetValue("singularity_vyList", {})
    local axList = state.GetValue("singularity_axList", {})
    local ayList = state.GetValue("singularity_ayList", {})

    local pulseStatus = state.GetValue("cache_pulseStatus", 0)

    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255

    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117

    local speed = clamp(math.abs(multiplier), 0, 4)
    if (dimX < 100 or imgui.GetTime() < 0.3) then return end

    createParticle(xList, yList, vxList, vyList, axList, ayList, dimX, dimY, 150)
    updateParticles(xList, yList, vxList, vyList, axList, ayList, dimX, dimY,
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
        local pos = { x + topLeft.x, y + topLeft.y }
        ctx.AddCircleFilled(pos, 2,
            rgbaToUint(r, g, b, 55 + pulseStatus * 200))
    end

    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295 - math.floor(pulseStatus * 120) * 16777216)
    ctx.AddCircle(dim / 2 + topLeft, 24 - pulseStatus * 8, 16777215 + math.floor(pulseStatus * 255) * 16777216)

    state.SetValue("singularity_xList", xList)
    state.SetValue("singularity_yList", yList)
    state.SetValue("singularity_vxList", vxList)
    state.SetValue("singularity_vyList", vyList)
    state.SetValue("singularity_axList", axList)
    state.SetValue("singularity_ayList", ayList)
end

function createParticle(x, y, vx, vy, ax, ay, dimX, dimY, n)
    if (#x >= n) then return end
    x[#x + 1] = math.random() * dimX
    y[#y + 1] = math.random() * dimY
    vx[#vx + 1] = 0
    vy[#vy + 1] = 0
    ax[#ax + 1] = 0
    ay[#ay + 1] = 0
end

function updateParticles(xl, yl, vxl, vyl, axl, ayl, dimX, dimY, dt, multiplier)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local spinDir = math.sign(multiplier)

    local movementSpeed = 0.1
    local bounceCoefficient = 0.8

    for i = 1, #xl do
        local x = xl[i]
        local y = yl[i]
        local vx = vxl[i]
        local vy = vyl[i]
        local ax = axl[i]
        local ay = ayl[i]

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

        axl[i] = gx + gy * spinFactor
        ayl[i] = gy - gx * spinFactor

        local movementDist = dt * movementSpeed

        vxl[i] = vx + ax * movementDist
        vyl[i] = vy + ay * movementDist
        xl[i] = x + vx * movementDist
        yl[i] = y + vy * movementDist

        if (x < 0 or x > dimX) then
            vxl[i] = -vxl[i] * bounceCoefficient
            xl[i] = clamp(xl[i], 1, dimX - 1)
        end
        if (y < 0 or y > dimY) then
            vyl[i] = -vyl[i] * bounceCoefficient
            yl[i] = clamp(yl[i], 1, dimY - 1)
        end

        local dragFactor = 1 - dt / 500

        vxl[i] = clamp(vxl[i] * dragFactor, -5, 5)
        vyl[i] = clamp(vyl[i] * dragFactor, -5, 5)
    end
end
