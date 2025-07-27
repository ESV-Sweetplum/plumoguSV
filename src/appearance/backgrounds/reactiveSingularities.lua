function renderReactiveSingularities()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local particles = state.GetValue("particles", {}) ---@type Particle[]
    local singularities = { { pos = dim / 2, v = vector.New(0.1, 0.1) } }

    local slowSpeed = vector.New(89, 0, 255)
    local fastSpeed = vector.New(255, 165, 117)

    if (dim.x < 100) then return end

    if (not truthy(#particles)) then
        createParticles(particles, 500)
    end
    updateParticles(particles, singularities, state.DeltaTime)

    for _, p in ipairs(particles) do
        local color = vector.Lerp(slowSpeed, fastSpeed, math.clamp(vector2Length(p.v) / 5, 0, 1))
        ctx.AddCircleFilled(p.pos + topLeft, 1.5,
            rgbaToUint(math.floor(color.x), math.floor(color.y), math.floor(color.z), 255))
    end
    for _, sg in ipairs(singularities) do
        ctx.AddCircleFilled(sg.pos + topLeft, 15, rgbaToUint(0, 0, 0, 255))
        ctx.AddCircle(sg.pos + topLeft, 16, rgbaToUint(255, 255, 255, 255))
    end

    state.SetValue("particles", particles)
end

function createParticles(particles, n)
    local dim = imgui.GetWindowSize()

    for i = 1, n do
        local pos = vector.New(math.random() * dim.x, math.random() * dim.y)

        table.insert(particles, {
            pos = pos,
            v = vector2(0),
            a = vector2(0),
        })
    end
end

function updateParticles(particles, singularities, dt)
    local dim = imgui.GetWindowSize()

    for _, p in ipairs(particles) do
        local movementSpeed = 0.1

        p.v = p.v + p.a * dt * movementSpeed
        p.pos = p.pos + p.v * dt * movementSpeed

        boundObject(p, 0.8)

        p.a = vector2(0)

        for _, sg in pairs(singularities) do
            local distVec = sg.pos - p.pos
            local g = distVec / (math.clamp(vector2Length(distVec), 10, 1e69) ^ 3) * 500
            p.a = p.a + g
            p.a = p.a + vector.New(g.y, -g.x) / math.sqrt(vector2Length(distVec)) * 10
        end
        p.v = vector.Clamp(p.v * (1 - dt / 1000 * 2), vector2(-5), vector2(5))
    end
end

function vector2Length(v)
    return math.sqrt(v.x ^ 2 + v.y ^ 2)
end

function boundObject(o, bounceCoefficient)
    local dim = imgui.GetWindowSize()

    if (o.pos.x < 0 or o.pos.x > dim.x) then
        o.v.x = -o.v.x * bounceCoefficient
        o.pos.x = math.clamp(o.pos.x, 1, dim.x - 1)
    end
    if (o.pos.y < 0 or o.pos.y > dim.y) then
        o.v.y = -o.v.y * bounceCoefficient
        o.pos.y = math.clamp(o.pos.y, 1, dim.y - 1)
    end
end
