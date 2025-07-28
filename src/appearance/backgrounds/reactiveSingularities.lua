function renderReactiveSingularities()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local sqrt = math.sqrt
    local clamp = math.clamp

    local xList = state.GetValue("xList", {})
    local yList = state.GetValue("yList", {})
    local vxList = state.GetValue("vxList", {})
    local vyList = state.GetValue("vyList", {})
    local axList = state.GetValue("axList", {})
    local ayList = state.GetValue("ayList", {})

    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255

    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117

    if (dim.x < 100) then return end

    if (not truthy(#xList)) then
        createParticles(xList, yList, vxList, vyList, axList, ayList, 300)
    end
    updateParticles(xList, yList, vxList, vyList, axList, ayList, dim, state.DeltaTime)

    local lerp = function(w, l, h)
        return w * h + (1 - w) * l
    end

    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local vx = vxList[i]
        local vy = vyList[i]
        local ax = axList[i]
        local ay = ayList[i]

        local s = sqrt(vx ^ 2 + vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = { x + topLeft.x, y + topLeft.y }
        ctx.AddCircleFilled(pos, 1.5,
            rgbaToUint(r, g, b, 255))
    end
    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295)

    state.SetValue("xList", xList)
    state.SetValue("yList", yList)
    state.SetValue("vxList", vxList)
    state.SetValue("vyList", vyList)
    state.SetValue("axList", axList)
    state.SetValue("ayList", ayList)
end

function createParticles(x, y, vx, vy, ax, ay, n)
    local dim = imgui.GetWindowSize()

    for i = 1, n do
        x[#x + 1] = math.random() * dim.x
        y[#y + 1] = math.random() * dim.y
        vx[#vx + 1] = 0
        vy[#vy + 1] = 0
        ax[#ax + 1] = 0
        ay[#ay + 1] = 0
    end
end

function updateParticles(xl, yl, vxl, vyl, axl, ayl, dim, dt)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local movementSpeed = 0.1

    for i = 1, #xl do
        local x = xl[i]
        local y = yl[i]
        local vx = vxl[i]
        local vy = vyl[i]
        local ax = axl[i]
        local ay = ayl[i]

        local bounceCoefficient = 0.8

        local sgPosx = dim.x / 2
        local sgPosy = dim.y / 2
        local xDist = sgPosx - x
        local yDist = sgPosy - y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        local sqrtDist = sqrt(dist)
        if (dist < 10) then dist = 10 end
        local gx = xDist / (dist ^ 3) * 500
        local gy = yDist / (dist ^ 3) * 500
        axl[i] = gx + gy / sqrtDist * 10
        ayl[i] = gy - gx / sqrtDist * 10

        vxl[i] = vx + ax * dt * movementSpeed
        vyl[i] = vy + ay * dt * movementSpeed
        xl[i] = x + vx * dt * movementSpeed
        yl[i] = y + vy * dt * movementSpeed

        if (x < 0 or x > dim.x) then
            vxl[i] = -vxl[i] * bounceCoefficient
            xl[i] = clamp(xl[i], 1, dim.x - 1)
        end
        if (y < 0 or y > dim.y) then
            vyl[i] = -vyl[i] * bounceCoefficient
            yl[i] = clamp(yl[i], 1, dim.y - 1)
        end

        vxl[i] = clamp(vxl[i] * (1 - dt / 1000 * 2), -5, 5)
        vyl[i] = clamp(vyl[i] * (1 - dt / 1000 * 2), -5, 5)
    end
end
