function renderReactiveSingularities()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local sqrt = math.sqrt
    local clamp = math.clamp

    local particles = state.GetValue("particles", {})

    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255

    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117

    if (dim.x < 100) then return end

    if (not truthy(#particles)) then
        createParticles(particles, 500)
    end
    updateParticles(particles, dim, state.DeltaTime)

    for _, p in ipairs(particles) do
        local s = sqrt(p.vx ^ 2 + p.vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = math.lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = math.lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = math.lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = { p.x + topLeft.x, p.y + topLeft.y }
        ctx.AddCircleFilled(pos, 1.5,
            rgbaToUint(r, g, b, 255))
    end
    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295)

    state.SetValue("particles", particles)
end

function createParticles(particles, n)
    local dim = imgui.GetWindowSize()

    for i = 1, n do
        table.insert(particles, {
            x = math.random() * dim.x,
            y = math.random() * dim.y,
            vx = 0,
            vy = 0,
            ax = 0,
            ay = 0
        })
    end
end

function updateParticles(particles, dim, dt)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local movementSpeed = 0.1

    for _, p in ipairs(particles) do
        p.vx = p.vx + p.ax * dt * movementSpeed
        p.vy = p.vy + p.ay * dt * movementSpeed
        p.x = p.x + p.vx * dt * movementSpeed
        p.y = p.y + p.vy * dt * movementSpeed

        boundObject(p, 0.8, clamp)

        local sgPosx = dim.x / 2
        local sgPosy = dim.y / 2
        local xDist = sgPosx - p.x
        local yDist = sgPosy - p.y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        local sqrtDist = sqrt(dist)
        if (dist < 10) then dist = 10 end
        local gx = xDist / (dist ^ 3) * 500
        local gy = yDist / (dist ^ 3) * 500
        p.ax = gx
        p.ay = gy
        p.ax = p.ax + gy / sqrtDist * 10
        p.ay = p.ay - gx / sqrtDist * 10
        p.vx = clamp(p.vx * (1 - dt / 1000 * 2), -5, 5)
        p.vy = clamp(p.vy * (1 - dt / 1000 * 2), -5, 5)
    end
end

function boundObject(o, bounceCoefficient, clamp)
    local dim = imgui.GetWindowSize()

    if (o.x < 0 or o.x > dim.x) then
        o.vx = -o.vx * bounceCoefficient
        o.x = clamp(o.x, 1, dim.x - 1)
    end
    if (o.y < 0 or o.y > dim.y) then
        o.vy = -o.vy * bounceCoefficient
        o.y = clamp(o.y, 1, dim.y - 1)
    end
end
